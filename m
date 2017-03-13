From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 13 Mar 2017 14:34:40 -0700
Subject: [PATCH 1/4] ARM: OMAP2+: dm81xx: Add clkdm and hwmod for SATA
In-Reply-To: <1489423399-3824-2-git-send-email-bgolaszewski@baylibre.com>
 (Bartosz Golaszewski's message of "Mon, 13 Mar 2017 17:43:16 +0100")
References: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
 <1489423399-3824-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <m27f3sc13j.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

> From: Kevin Hilman <khilman@baylibre.com>
>
> Add the SATA clockdomain (part of CM_DEFAULT) and a hwmod for the SATA
> block on dm81xx.
>
> Tested on DM8168 EVM.
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-omap2/clockdomains81xx_data.c | 10 +++++++++
>  arch/arm/mach-omap2/cm81xx.h                |  2 ++
>  arch/arm/mach-omap2/omap_hwmod_81xx_data.c  | 34 +++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/clockdomains81xx_data.c b/arch/arm/mach-omap2/clockdomains81xx_data.c
> index 3b5fb05..65fbd13 100644
> --- a/arch/arm/mach-omap2/clockdomains81xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains81xx_data.c
> @@ -91,6 +91,14 @@ static struct clockdomain default_l3_slow_81xx_clkdm = {
>  	.flags		= CLKDM_CAN_SWSUP,
>  };
>  
> +static struct clockdomain default_sata_81xx_clkdm = {
> +	.name		= "default_clkdm",
> +	.pwrdm		= { .name = "default_pwrdm" },
> +	.cm_inst	= TI81XX_CM_DEFAULT_MOD,
> +	.clkdm_offs	= TI816X_CM_DEFAULT_SATA_CLKDM,
> +	.flags		= CLKDM_CAN_SWSUP,
> +};
> +
>  /* 816x only */
>  
>  static struct clockdomain alwon_mpu_816x_clkdm = {
> @@ -173,6 +181,7 @@ static struct clockdomain *clockdomains_ti814x[] __initdata = {
>  	&mmu_81xx_clkdm,
>  	&mmu_cfg_81xx_clkdm,
>  	&default_l3_slow_81xx_clkdm,
> +	&default_sata_81xx_clkdm,
>  	NULL,
>  };
>  
> @@ -200,6 +209,7 @@ static struct clockdomain *clockdomains_ti816x[] __initdata = {
>  	&default_ducati_816x_clkdm,
>  	&default_pci_816x_clkdm,
>  	&default_l3_slow_81xx_clkdm,
> +	&default_sata_81xx_clkdm,
>  	NULL,
>  };
>  
> diff --git a/arch/arm/mach-omap2/cm81xx.h b/arch/arm/mach-omap2/cm81xx.h
> index 3a0ccf0..44ca275 100644
> --- a/arch/arm/mach-omap2/cm81xx.h
> +++ b/arch/arm/mach-omap2/cm81xx.h
> @@ -35,6 +35,7 @@
>  #define TI81XX_CM_MMU_CLKDM			0x000C
>  #define TI81XX_CM_MMUCFG_CLKDM			0x0010
>  #define TI81XX_CM_ALWON_MPU_CLKDM		0x001C
> +#define TI81XX_CM_ALWON_SYSCLK5_CLKDM		0x0024

oops, this is a stray addition (by me) but is no not needed.

>  #define TI81XX_CM_ALWON_L3_FAST_CLKDM		0x0030
>  

Kevin
