From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 Feb 2011 14:55:17 +0300
Subject: [PATCH v1 3/9] da850: pruss platform specific additions.
In-Reply-To: <1296571667-12049-4-git-send-email-subhasish@mistralsolutions.com>
References: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
	<1296571667-12049-4-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D494625.4030503@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-02-2011 17:47, Subhasish Ghosh wrote:

> This patch adds the platform device and assignes the platform resources
> for the PRUSS mfd driver.

> Signed-off-by: Subhasish Ghosh<subhasish@mistralsolutions.com>
[...]

> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 3443d97..341d836 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -238,6 +238,12 @@ static struct clk tptc2_clk = {
>   	.flags		= ALWAYS_ENABLED,
>   };
>
> +static struct clk pruss_clk = {
> +	.name		= "pruss",
> +	.parent		= &pll0_sysclk2,
> +	.lpsc		= DA8XX_LPSC0_DMAX,

    IIRC, you were asked to change/add a new name for what is known as 
DA8XX_LPSC0_DMAX...

> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index beda8a4..562882c 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c

> +struct platform_device da8xx_pruss_dev = {
> +	.name			=	"da8xx_pruss",
> +	.id				=	-1,
> +	.num_resources	=	ARRAY_SIZE(da8xx_pruss_resources),
> +	.resource		=	da8xx_pruss_resources,

    Please align = uniformly.

> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
> index cfcb223..e5c178a 100644
> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
[...]
> @@ -81,6 +82,7 @@ int da8xx_register_watchdog(void);
>  int da8xx_register_usb20(unsigned mA, unsigned potpgt);
>  int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
>  int da8xx_register_emac(void);
> +int da8xx_register_pruss(struct da8xx_pruss_devices *);
>  int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
>  int da8xx_register_mmcsd0(struct davinci_mmc_config *config);
>  int da850_register_mmcsd1(struct davinci_mmc_config *config);

    This patch should clearly precede the patch 2/9 as it defines 
da8xx_register_pruss() which 2/9 uses.

WBR, Sergei
