From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 19 Dec 2013 08:24:50 +0200
Subject: [PATCH 2/3] thermal: imx: add necessary clk operation
In-Reply-To: <1387477045-19037-2-git-send-email-b20788@freescale.com>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
 <1387477045-19037-2-git-send-email-b20788@freescale.com>
Message-ID: <20131219062450.GC4148@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Thu, Dec 19, 2013 at 01:17:24PM -0500, Anson Huang wrote:
> +	if (IS_ERR(data->thermal_clk)) {
> +		ret = IS_ERR(data->thermal_clk);

You probably what to return PTR_ERR here.

baruch

> +		dev_err(&pdev->dev, "failed to get thermal clk!\n");
> +		return ret;
> +	}

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
