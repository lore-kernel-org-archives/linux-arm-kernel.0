From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 Sep 2016 14:47:30 -0700
Subject: [PATCH v3 3/3] clk: mvebu: migrate CP110 system controller to
 clk_hw API and registration
In-Reply-To: <1474448759-24482-4-git-send-email-mw@semihalf.com>
References: <1474448759-24482-1-git-send-email-mw@semihalf.com>
 <1474448759-24482-4-git-send-email-mw@semihalf.com>
Message-ID: <20160923214730.GF21232@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21, Marcin Wojtas wrote:
> @@ -203,80 +202,75 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	cp110_clks = devm_kcalloc(&pdev->dev, sizeof(struct clk *),
> -				  CP110_CLK_NUM, GFP_KERNEL);
> -	if (!cp110_clks)
> -		return -ENOMEM;
> -
> -	cp110_clk_data = devm_kzalloc(&pdev->dev,
> -				      sizeof(*cp110_clk_data),
> +	cp110_clk_data = devm_kcalloc(&pdev->dev, sizeof(*cp110_clk_data),
> +				      sizeof(struct clk_hw *) * CP110_CLK_NUM,
>  				      GFP_KERNEL);

This doesn't look right. Why are calloc()ing clk_hw_onecell_data this
way?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
