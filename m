From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Sep 2010 01:12:27 +0200
Subject: [PATCH 16/74] ST SPEAr: adding support for synopsis i2c designware
In-Reply-To: <72ad657ab3eb9d61f11741145494eadb061926b9.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<72ad657ab3eb9d61f11741145494eadb061926b9.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100906231227.GG8153@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
> index 147d0a3..ae6c244 100644
> --- a/arch/arm/mach-spear3xx/clock.c
> +++ b/arch/arm/mach-spear3xx/clock.c
> @@ -460,6 +460,15 @@ static struct clk gpio_clk = {
>  
>  static struct clk dummy_apb_pclk;
>  
> +#ifdef CONFIG_MACH_SPEAR320
> +/* i2c1 clock */
> +static struct clk i2c1_clk = {
> +	.flags = ALWAYS_ENABLED,
> +	.pclk = &ahb_clk,
> +	.recalc = &follow_parent,
> +};
> +#endif
> +
>  /* array of all spear 3xx clock lookups */
>  static struct clk_lookup spear_clk_lookups[] = {
>  	{ .con_id = "apb_pclk",	.clk = &dummy_apb_pclk},
> @@ -491,7 +500,7 @@ static struct clk_lookup spear_clk_lookups[] = {
>  	{ .dev_id = "clcd",		.clk = &clcd_clk},
>  	/* clock derived from ahb clk */
>  	{ .con_id = "apb_clk",		.clk = &apb_clk},
> -	{ .dev_id = "i2c",		.clk = &i2c_clk},
> +	{ .dev_id = "i2c_designware.0",	.clk = &i2c_clk},
>  	{ .dev_id = "dma",		.clk = &dma_clk},
>  	{ .dev_id = "jpeg",		.clk = &jpeg_clk},
>  	{ .dev_id = "gmac",		.clk = &gmac_clk},
> @@ -501,6 +510,9 @@ static struct clk_lookup spear_clk_lookups[] = {
>  	{ .dev_id = "adc",		.clk = &adc_clk},
>  	{ .dev_id = "ssp",		.clk = &ssp_clk},
>  	{ .dev_id = "gpio",		.clk = &gpio_clk},
> +#ifdef CONFIG_MACH_SPEAR320
> +	{ .dev_id = "i2c_designware.1",	.clk = &i2c1_clk},
> +#endif
how about split this file in 2
one for 320 and one for 310 so we can avoid all this ifdef

Best Regards,
J.
