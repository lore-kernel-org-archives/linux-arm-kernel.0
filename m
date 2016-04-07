From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 7 Apr 2016 16:31:13 -0700
Subject: [PATCH 1/2] clk: Add Oxford Semiconductor OXNAS Standard Clocks
In-Reply-To: <5701210A.4060807@baylibre.com>
References: <1459520791-13269-1-git-send-email-narmstrong@baylibre.com>
 <1459520791-13269-2-git-send-email-narmstrong@baylibre.com>
 <20160402005045.GX18567@codeaurora.org>
 <5701210A.4060807@baylibre.com>
Message-ID: <20160407233113.GI18567@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03, Neil Armstrong wrote:
> On 04/02/2016 02:50 AM, Stephen Boyd wrote:
> > On 04/01, Neil Armstrong wrote:
> >> +	if (!onecell_data)
> >> +		return -ENOMEM;
> >> +
> >> +	regmap = syscon_node_to_regmap(of_get_parent(np));
> > 
> > Can we use dev_get_regmap(&pdev->dev.parent) here instead? I'd
> > prefer device APIs over DT APIs here. 
> > 
> 
> It will not work here since the parent node is a syscon, the call to syscon_node_to_regmap() will call of_syscon_register() and create the regmap, the dev_get_regmap() needs a proper platform device registered as regmap here.
> 

Ok. I was hoping that we could make simple-mfd look to see if
there's a syscon and then attach it to the parent device, but it
seems that simple-mfd is not actually a driver and it might not
even make a parent device for the children nodes?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
