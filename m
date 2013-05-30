From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 30 May 2013 22:46:04 +0800
Subject: [PATCH] ARM: imx: Remove mxc specific ulpi access ops
In-Reply-To: <1369917895-9562-1-git-send-email-mpa@pengutronix.de>
References: <1369917895-9562-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20130530144601.GA22013@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 02:44:55PM +0200, Markus Pargmann wrote:
> There are ulpi access ops implemented in drivers/usb/phy/phy-ulpi.c.
> mxc access ops implement the same access operations within mach-imx. This
> patch removes the mxc ulpi file and uses phy-ulpi instead for
> imx_otg_ulpi_create.
> 
> phy-ulpi successfully tested with i.MX27 Phytec phyCARD-S (pca100).
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/Kconfig       |   1 +
>  arch/arm/mach-imx/Makefile      |   1 -
>  arch/arm/mach-imx/mach-pca100.c |   4 +-
>  arch/arm/mach-imx/ulpi.c        | 118 ----------------------------------------
>  arch/arm/mach-imx/ulpi.h        |   9 ++-
>  5 files changed, 9 insertions(+), 124 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/ulpi.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index ba44328..ca59799 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -58,6 +58,7 @@ config MXC_USE_EPIT
>  
>  config MXC_ULPI
>  	bool
> +	select USB_ULPI_VIEWPORT

Is MXC_ULPI still used anywhere after you remove ulpi.c in the patch?
You are even patching it, so I'm a little confused.

Shawn
