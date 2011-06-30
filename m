From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 30 Jun 2011 09:55:01 +0200
Subject: [PATCH v5 2/3] ARM: mxs/mx23evk: add GPMI-NFC device
In-Reply-To: <1309406028-2924-3-git-send-email-b32955@freescale.com>
References: <1309406028-2924-1-git-send-email-b32955@freescale.com>
	<1309406028-2924-3-git-send-email-b32955@freescale.com>
Message-ID: <20110630075501.GE11559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 11:53:47AM +0800, Huang Shijie wrote:
> add the GPMI-NFC device for mx23evk borad.
s/borad/board/

> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/mach-mxs/Kconfig        |    1 +
>  arch/arm/mach-mxs/mach-mx23evk.c |   37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 1d3985f..f55bcfe 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -32,6 +32,7 @@ config MACH_MX23EVK
>  	select SOC_IMX23
>  	select MXS_HAVE_AMBA_DUART
>  	select MXS_HAVE_PLATFORM_AUART
> +	select MXS_HAVE_PLATFORM_GPMI_NFC
>  	select MXS_HAVE_PLATFORM_MXS_MMC
>  	select MXS_HAVE_PLATFORM_MXSFB
>  	help
> diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
> index 3c2de33..772b373 100644
> --- a/arch/arm/mach-mxs/mach-mx23evk.c
> +++ b/arch/arm/mach-mxs/mach-mx23evk.c
> @@ -107,6 +107,42 @@ static const iomux_cfg_t mx23evk_pads[] __initconst = {
>  		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
>  };
>  
> +/* gpmi-nfc */
> +#define MXS_PAD_GPMI_NFC	(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL)
Maybe put that into a more central place, as mach-mx28evk uses it, too?
OTOH the name sounds more generic than its use. Do you really need 12mA
for the Write protect pin? If not, you could rename it to
MXS_PAD_GPMI_NFC_STROBE.

> +static iomux_cfg_t mx23evk_gpmi_nfc_pads[] = {
> +	MX23_PAD_GPMI_D00__GPMI_D00 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D01__GPMI_D01 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D02__GPMI_D02 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D03__GPMI_D03 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D04__GPMI_D04 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D05__GPMI_D05 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D06__GPMI_D06 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_D07__GPMI_D07 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_CLE__GPMI_CLE | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_ALE__GPMI_ALE | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_WPN__GPMI_WPN | MXS_PAD_GPMI_NFC,
> +	MX23_PAD_GPMI_WRN__GPMI_WRN | MXS_PAD_GPMI_NFC,
> +	MX23_PAD_GPMI_RDN__GPMI_RDN | MXS_PAD_GPMI_NFC,
> +	MX23_PAD_GPMI_RDY0__GPMI_RDY0 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_RDY1__GPMI_RDY1 | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_CE0N__GPMI_CE0N | MXS_PAD_CTRL,
> +	MX23_PAD_GPMI_CE1N__GPMI_CE1N | MXS_PAD_CTRL,
> +};

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
