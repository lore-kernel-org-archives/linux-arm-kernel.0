From: joe@perches.com (Joe Perches)
Date: Fri, 16 Jul 2010 16:49:27 -0700
Subject: [PATCH] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <E1OZlTF-0006NW-1I@wanda>
References: <E1OZlTF-0006NW-1I@wanda>
Message-ID: <1279324167.4526.85.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-07-16 at 10:00 -0400, Michael Williamson wrote:
> +static __init void mityomapl138_setup_lcd(void)
> +{
[]
> +			pr_warning("mityomapl138_init: unknown LCD type : %s\n",
> +				peripheral_config.LCDConfig.PanelName);

I think you'd be better off actually using the actual
function name rather than the caller name

			pr_warning("%s: unknown LCD type: %s\n",
				   __func__, peripheral_config.LCDConfig.PanelName);

[]
> +		if (ret) {
> +			pr_warning("mityomapl138_init: lcd pinmux failed : "
> +				   "%d\n", ret);


			pr_warning("%s: lcd pinmux failed : %d\n",
				   __func__, ret);

> +		pr_warning("mityomapl138_init: no LCD device enabled\n");

etc.

> +static __init void mityomapl138_init(void)
> +{
> +	int ret;
> +
> +	pr_info("mityomapl138_init...\n");
> +
> +	ret = pmic_tps65023_init();
> +	if (ret)
> +		pr_warning("mityomapl138_init: TPS65023 PMIC init failed: %d\n",
> +				ret);

		pr_warning("%s: TPS65023 PMIC init failed: %d\n",
			   __func__, ret);

etc.

> +
> +	ret = da8xx_register_edma();
> +	if (ret)
> +		pr_warning("mityomapl138_init: edma registration failed: %d\n",
> +				ret);
> +
> +	ret = da8xx_register_i2c(0, &mityomap_i2c_0_pdata);
> +	if (ret)
> +		pr_warning("mityomapl138_init: i2c0 registration failed: %d\n",
> +				ret);
> +
> +	ret = da8xx_register_watchdog();
> +	if (ret)
> +		pr_warning("mityomapl138_init: watchdog registration failed: "
> +			   "%d\n", ret);
> +
