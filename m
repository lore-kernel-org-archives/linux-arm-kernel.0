From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 14 Nov 2012 14:12:45 +0400
Subject: [PATCH v3 1/6] ARM: davinci: Changed pr_warning() to pr_warn()
 (part 1)
In-Reply-To: <1352853207-20602-1-git-send-email-rtivy@ti.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
Message-ID: <50A36E9D.5060405@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 14-11-2012 4:33, Robert Tivy wrote:

     These subjects are not very good too -- it's better to specify the scope 
of the changes, like "ARM: DaVinci: DA850 EVM: change pr_warning() to pr_warn()".

> Also, while modifying those pr_warning() calls I changed hardcoded
> function names to use '"%s:", __func__' instead

> Signed-off-by: Robert Tivy <rtivy@ti.com>
> ---
> Clean up files that will be otherwise modified in subsequent patch.

> Applies to v3.7-rc2 tag (commit 6f0c0580b70c89094b3422ba81118c7b959c7556) of
> Linus' mainline kernel at git.kernel.org.

>   arch/arm/mach-davinci/board-da850-evm.c |  102 +++++++++++++------------------
>   1 file changed, 43 insertions(+), 59 deletions(-)

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 32ee3f8..6c172b3 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -347,13 +347,13 @@ static inline void da850_evm_setup_nor_nand(void)
>   	if (!HAS_MMC) {
>   		ret = davinci_cfg_reg_list(da850_evm_nand_pins);
>   		if (ret)
> -			pr_warning("da850_evm_init: nand mux setup failed: "
> -					"%d\n", ret);
> +			pr_warn("%s: nand mux setup failed: %d\n",

    My preference is to have the acronyms capitalized, so I'd changed to 
"NAND", while at it.

> +				__func__, ret);
>
>   		ret = davinci_cfg_reg_list(da850_evm_nor_pins);
>   		if (ret)
> -			pr_warning("da850_evm_init: nor mux setup failed: %d\n",
> -				ret);
> +			pr_warn("%s: nor mux setup failed: %d\n",

    ... and to "NOR" here.

> @@ -688,14 +688,14 @@ static int da850_evm_bb_expander_setup(struct i2c_client *client,
>   	da850_evm_bb_keys_init(gpio);
>   	ret = platform_device_register(&da850_evm_bb_keys_device);
>   	if (ret) {
> -		pr_warning("Could not register baseboard GPIO expander keys");
> +		pr_warn("Could not register baseboard GPIO expander keys");
>   		goto io_exp_setup_sw_fail;
>   	}
>
>   	da850_evm_bb_leds_init(gpio);
>   	ret = platform_device_register(&da850_evm_bb_leds_device);
>   	if (ret) {
> -		pr_warning("Could not register baseboard GPIO expander LEDS");
> +		pr_warn("Could not register baseboard GPIO expander LEDS");

    It's "LEDs".

> @@ -1060,21 +1060,19 @@ static int __init da850_evm_config_emac(void)
>   	}
>
>   	if (ret)
> -		pr_warning("da850_evm_init: cpgmac/rmii mux setup failed: %d\n",
> -				ret);
> +		pr_warn("%s: cpgmac/rmii mux setup failed: %d\n",

    I'd have changed to "CPGMAC/RMII".

> @@ -1085,8 +1083,7 @@ static int __init da850_evm_config_emac(void)
>
>   	ret = da8xx_register_emac();
>   	if (ret)
> -		pr_warning("da850_evm_init: emac registration failed: %d\n",
> -				ret);
> +		pr_warn("%s: emac registration failed: %d\n", __func__, ret);

    ... and to "EMAC" here.

> @@ -1438,57 +1435,53 @@ static __init void da850_evm_init(void)
>
>   	ret = pmic_tps65070_init();
>   	if (ret)
> -		pr_warning("da850_evm_init: TPS65070 PMIC init failed: %d\n",
> -				ret);
> +		pr_warn("%s: TPS65070 PMIC init failed: %d\n", __func__, ret);
>
>   	ret = da850_register_edma(da850_edma_rsv);
>   	if (ret)
> -		pr_warning("da850_evm_init: edma registration failed: %d\n",
> -				ret);
> +		pr_warn("%s: edma registration failed: %d\n", __func__, ret);

    ... and to "EDMA" here.

>   	ret = davinci_cfg_reg_list(da850_i2c0_pins);
>   	if (ret)
> -		pr_warning("da850_evm_init: i2c0 mux setup failed: %d\n",
> -				ret);
> +		pr_warn("%s: i2c0 mux setup failed: %d\n", __func__, ret);

    ... and to "I2C0" here.

>
>   	ret = da8xx_register_i2c(0, &da850_evm_i2c_0_pdata);
>   	if (ret)
> -		pr_warning("da850_evm_init: i2c0 registration failed: %d\n",
> -				ret);
> +		pr_warn("%s: i2c0 registration failed: %d\n", __func__, ret);

    ... and here.

>   	if (HAS_MMC) {
>   		ret = davinci_cfg_reg_list(da850_evm_mmcsd0_pins);
>   		if (ret)
> -			pr_warning("da850_evm_init: mmcsd0 mux setup failed:"
> -					" %d\n", ret);
> +			pr_warn("%s: mmcsd0 mux setup failed: %d\n",

    ... and to "MMCSD0" here.

[...]
>   		if (ret)
> -			pr_warning("da850_evm_init: mmcsd0 registration failed:"
> -					" %d\n", ret);
> +			pr_warn("%s: mmcsd0 registration failed: %d\n",

    ... and here.

> +				__func__, ret);
>
>   		ret = da850_wl12xx_init();
>   		if (ret)
> -			pr_warning("da850_evm_init: wl12xx initialization"
> -				   " failed: %d\n", ret);
> +			pr_warn("%s: wl12xx initialization failed: %d\n",

    ... and to "WL12xx" here.

> @@ -1506,64 +1499,55 @@ static __init void da850_evm_init(void)
>
>   	ret = davinci_cfg_reg_list(da850_evm_mcasp_pins);
>   	if (ret)
> -		pr_warning("da850_evm_init: mcasp mux setup failed: %d\n",
> -				ret);
> +		pr_warn("%s: mcasp mux setup failed: %d\n", __func__, ret);

    To "McASP" here.

>
>   	da8xx_register_mcasp(0, &da850_evm_snd_data);
>
>   	ret = davinci_cfg_reg_list(da850_lcdcntl_pins);
>   	if (ret)
> -		pr_warning("da850_evm_init: lcdcntl mux setup failed: %d\n",
> -				ret);
> +		pr_warn("%s: lcdcntl mux setup failed: %d\n", __func__, ret);

    To "LCDC" here.
>
>   	/* Handle board specific muxing for LCD here */
>   	ret = davinci_cfg_reg_list(da850_evm_lcdc_pins);
>   	if (ret)
> -		pr_warning("da850_evm_init: evm specific lcd mux setup "
> -				"failed: %d\n",	ret);
> +		pr_warn("%s: evm specific lcd mux setup failed: %d\n",

    "EVM" and "LCD" here.

> +			__func__, ret);
>
>   	ret = da850_lcd_hw_init();
>   	if (ret)
> -		pr_warning("da850_evm_init: lcd initialization failed: %d\n",
> -				ret);
> +		pr_warn("%s: lcd initialization failed: %d\n", __func__, ret);

    "LCD" here.

>
>   	sharp_lk043t1dg01_pdata.panel_power_ctrl = da850_panel_power_ctrl,
>   	ret = da8xx_register_lcdc(&sharp_lk043t1dg01_pdata);
>   	if (ret)
> -		pr_warning("da850_evm_init: lcdc registration failed: %d\n",
> -				ret);
> +		pr_warn("%s: lcdc registration failed: %d\n", __func__, ret);

    "LCDC" here.

>
>   	ret = da8xx_register_rtc();
>   	if (ret)
> -		pr_warning("da850_evm_init: rtc setup failed: %d\n", ret);
> +		pr_warn("%s: rtc setup failed: %d\n", __func__, ret);

    "RTC" here.

>
>   	ret = da850_evm_init_cpufreq();
>   	if (ret)
> -		pr_warning("da850_evm_init: cpufreq registration failed: %d\n",
> -				ret);
> +		pr_warn("%s: cpufreq registration failed: %d\n", __func__, ret);
>
>   	ret = da8xx_register_cpuidle();
>   	if (ret)
> -		pr_warning("da850_evm_init: cpuidle registration failed: %d\n",
> -				ret);
> +		pr_warn("%s: cpuidle registration failed: %d\n", __func__, ret);
>
>   	ret = da850_register_pm(&da850_pm_device);
>   	if (ret)
> -		pr_warning("da850_evm_init: suspend registration failed: %d\n",
> -				ret);
> +		pr_warn("%s: suspend registration failed: %d\n", __func__, ret);
>
>   	da850_vpif_init();
>
>   	ret = da8xx_register_spi(1, da850evm_spi_info,
>   				 ARRAY_SIZE(da850evm_spi_info));
>   	if (ret)
> -		pr_warning("da850_evm_init: spi 1 registration failed: %d\n",
> -				ret);
> +		pr_warn("%s: spi 1 registration failed: %d\n", __func__, ret);

    "SPI" here.

>
>   	ret = da850_register_sata(DA850EVM_SATA_REFCLKPN_RATE);
>   	if (ret)
> -		pr_warning("da850_evm_init: sata registration failed: %d\n",
> -				ret);
> +		pr_warn("%s: sata registration failed: %d\n", __func__, ret);

    "SATA" here.

WBR, Sergei
