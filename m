From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 15 Oct 2015 12:28:59 -0700
Subject: [PATCH 07/13] clk: versatile-icst: refactor to allocate regmap
 separately
In-Reply-To: <1444916813-31024-8-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-8-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151015192859.GQ4558@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Linus Walleij wrote:
> @@ -140,21 +141,16 @@ static const struct clk_ops icst_ops = {
>  	.set_rate = icst_set_rate,
>  };
>  
> -struct clk *icst_clk_register(struct device *dev,
> +struct clk *icst_clk_setup(struct device *dev,

This needs static now.

>  			const struct clk_icst_desc *desc,
>  			const char *name,
>  			const char *parent_name,
> -			void __iomem *base)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
