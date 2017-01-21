From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 16:16:48 -0800
Subject: [PATCH v5 01/12] clk: apn806: Add eMMC clock to system
 controller driver
In-Reply-To: <e84d52dfbd9f7d2a14a5ec9d53918119fdc90404.1484154449.git-series.gregory.clement@free-electrons.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <e84d52dfbd9f7d2a14a5ec9d53918119fdc90404.1484154449.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170121001648.GJ20800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11, Gregory CLEMENT wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
> 
> Add fixed clock of 400MHz to system controller driver.  This clock is
> used as SD/eMMC clock source.
> 
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> Reviewed-by: Omri Itach <omrii@marvell.com>
> Reviewed-by: Hanna Hawa <hannah@marvell.com>
> [fixed up conflicts, added error handling --rmk]
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

> diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
> index 8181b919f062..0a785076b0c6 100644
> --- a/drivers/clk/mvebu/ap806-system-controller.c
> +++ b/drivers/clk/mvebu/ap806-system-controller.c
> @@ -117,6 +117,17 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
>  		goto fail3;
>  	}
>  
> +	/* eMMC Clock is fixed clock divided by 3 */
> +	of_property_read_string_index(np, "clock-output-names",
> +				      4, &name);

This could check for failure and not register the clk if the name
isn't there? Then dts can be backwards compatible.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
