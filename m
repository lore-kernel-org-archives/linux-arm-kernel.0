From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Dec 2010 09:13:28 +0100
Subject: [PATCH v2 5/8] arm: mxc: move IOMUX_CONFIG_XXXX definitions to
	iomux-v3.h
In-Reply-To: <1293607828-21213-5-git-send-email-richard.zhao@freescale.com>
References: <1293607828-21213-1-git-send-email-richard.zhao@freescale.com>
	<1293607828-21213-2-git-send-email-richard.zhao@freescale.com>
	<1293607828-21213-3-git-send-email-richard.zhao@freescale.com>
	<1293607828-21213-4-git-send-email-richard.zhao@freescale.com>
	<1293607828-21213-5-git-send-email-richard.zhao@freescale.com>
Message-ID: <20101229081328.GL14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 29, 2010 at 03:30:27PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h |   16 ----------------
>  arch/arm/plat-mxc/include/mach/iomux-mx53.h |   16 ----------------
>  arch/arm/plat-mxc/include/mach/iomux-v3.h   |   15 +++++++++++++++
>  3 files changed, 15 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> index e1600f3..31af1f5 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> @@ -15,22 +15,6 @@
>  
>  #include <mach/iomux-v3.h>
>  
> -/*
> - * various IOMUX alternate output functions (1-7)
> - */
> -typedef enum iomux_config {
> -	IOMUX_CONFIG_ALT0,
> -	IOMUX_CONFIG_ALT1,
> -	IOMUX_CONFIG_ALT2,
> -	IOMUX_CONFIG_ALT3,
> -	IOMUX_CONFIG_ALT4,
> -	IOMUX_CONFIG_ALT5,
> -	IOMUX_CONFIG_ALT6,
> -	IOMUX_CONFIG_ALT7,
> -	IOMUX_CONFIG_GPIO,      /* added to help user use GPIO mode */
> -	IOMUX_CONFIG_SION = 0x1 << 4,   /* LOOPBACK:MUX SION bit */
> -} iomux_pin_cfg_t;
> -
>  /* Pad control groupings */
>  #define MX51_UART1_PAD_CTRL	(PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_PUE | \
>  				PAD_CTL_DSE_HIGH)
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> index 80cb3c5..4155124 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> @@ -21,22 +21,6 @@
>  
>  #include <mach/iomux-v3.h>
>  
> -/*
> - * various IOMUX alternate output functions (1-7)
> - */
> -typedef enum iomux_config {
> -	IOMUX_CONFIG_ALT0,
> -	IOMUX_CONFIG_ALT1,
> -	IOMUX_CONFIG_ALT2,
> -	IOMUX_CONFIG_ALT3,
> -	IOMUX_CONFIG_ALT4,
> -	IOMUX_CONFIG_ALT5,
> -	IOMUX_CONFIG_ALT6,
> -	IOMUX_CONFIG_ALT7,
> -	IOMUX_CONFIG_GPIO, /* added to help user use GPIO mode */
> -	IOMUX_CONFIG_SION = 0x1 << 4, /* LOOPBACK:MUX SION bit */
> -} iomux_pin_cfg_t;
> -
>  /* These 2 defines are for pins that may not have a mux register, but could
>   * have a pad setting register, and vice-versa. */
>  #define NON_MUX_I	0x00
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> index 811716f..e1fd71b 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> @@ -54,6 +54,21 @@ typedef struct deprecated_pad_desc {
>  	unsigned select_input:3;
>  } iomux_v3_cfg_t;
>  
> +/*
> + * various IOMUX alternate output functions (1-7)
> + */
> +enum iomux_config {
> +	IOMUX_CONFIG_ALT0,
> +	IOMUX_CONFIG_ALT1,
> +	IOMUX_CONFIG_ALT2,
> +	IOMUX_CONFIG_ALT3,
> +	IOMUX_CONFIG_ALT4,
> +	IOMUX_CONFIG_ALT5,
> +	IOMUX_CONFIG_ALT6,
> +	IOMUX_CONFIG_ALT7,
> +	IOMUX_CONFIG_SION = 0x1 << 4,	/* LOOPBACK:MUX SION bit */
You didn't add IOMUX_CONFIG_GPIO here which existed in both iomux-mx51.h
and iomux-mx53.h.  Either you should add it or note in the commit log
why you choosed not to do it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
