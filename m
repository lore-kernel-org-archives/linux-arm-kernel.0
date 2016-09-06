From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 6 Sep 2016 20:59:51 +0300
Subject: [PATCH v2 2/3] clk: mvebu: dynamically allocate resources in
 Armada CP110 system controller
In-Reply-To: <1473183117-11889-3-git-send-email-mw@semihalf.com>
References: <1473183117-11889-1-git-send-email-mw@semihalf.com>
 <1473183117-11889-3-git-send-email-mw@semihalf.com>
Message-ID: <20160906175951.etybwtilfvyclrdb@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,

On Tue, Sep 06, 2016 at 07:31:56PM +0200, Marcin Wojtas wrote:
> +	cp110_clks = devm_kcalloc(&pdev->dev, sizeof(struct clk *),
> +				  CP110_CLK_NUM, GFP_KERNEL);
> +	if (!cp110_clks)
> +		return PTR_ERR(cp110_clks);

PTR_ERR(NULL) translates to 0. Should probably just return -ENOMEM.

> +	cp110_clk_data = devm_kzalloc(&pdev->dev,
> +				      sizeof(*cp110_clk_data),
> +				      GFP_KERNEL);
> +	if (!cp110_clk_data)
> +		return PTR_ERR(cp110_clk_data);

Ditto.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
