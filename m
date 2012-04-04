From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Apr 2012 16:32:05 -0600
Subject: [PATCH V2 4/4] SPEAr3xx: Add pinctrl support for boards
In-Reply-To: <1ac94a157f9b15d0eabce4768ff83338cbd4ff4a.1333538870.git.viresh.kumar@st.com>
References: <cover.1333538869.git.viresh.kumar@st.com>
 <1ac94a157f9b15d0eabce4768ff83338cbd4ff4a.1333538870.git.viresh.kumar@st.com>
Message-ID: <4F7CCBE5.8020703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2012 05:35 AM, Viresh Kumar wrote:
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

> +++ b/arch/arm/mach-spear3xx/spear300.c

> +static struct pinctrl_map __initdata spear300_evb_pmx_map[] = {
> +	/* spear3xx per-device maps */
> +	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", NULL, "i2c0"),
> +	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", NULL, "ssp0"),
> +	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", NULL, "mii0"),
> +	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", NULL, "uart0"),
> +
> +	/* spear310 per-device maps */
> +	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", "clcd_pfmode_grp",
> +			"clcd"),
> +	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", "sdhci_4bit_grp",
> +			"sdhci"),
> +	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", "gpio1_0_to_3_grp",
> +			"gpio"),
> +	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", "gpio1_4_to_7_grp",
> +			"gpio"),
> +};
>
>  static void __init spear300_dt_init(void)
...
> +
> +	if (of_machine_is_compatible("st,spear300-evb")) {
> +		if (pinctrl_register_mappings(spear300_evb_pmx_map,
> +					ARRAY_SIZE(spear300_evb_pmx_map)))
> +			pr_err("Error registering pinmux map\n");
> +	}

It'd be nice to put those mapping tables into device tree from the
start. Hopefully the core pinctrl support for DT will be in linux-next
today/tomorrow.
