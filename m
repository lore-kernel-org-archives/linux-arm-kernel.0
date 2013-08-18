From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 18 Aug 2013 17:12:06 +0800
Subject: [PATCH v2 1/2] ARM: imx_v6_v7_defconfig: Remove CONFIG_USB_PHY
 selection
In-Reply-To: <1376486268-31599-1-git-send-email-festevam@gmail.com>
References: <1376486268-31599-1-git-send-email-festevam@gmail.com>
Message-ID: <20130818091202.GA15070@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 10:17:47AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 052a11d1 (usb: phy: make PHY driver selection possible by
> controller drivers), CONFIG_USB_PHY is selected via drivers/usb/phy/Kconfig, so
> there is no need to select it via defconfig anymore.

Applying the patch on IMX tree will break the boot right away, because
the prerequisite commit 052a11d1 is available on IMX tree and causes
CONFIG_USB_PHY lost.  So please do not send me such patches until the
prerequisite ones hit mainline.

Also, I do not think the change is worth a patch, since it will go away
when next time we run savedefconfig.

Shawn

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Split it in two patches
> 
>  arch/arm/configs/imx_v6_v7_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 5d488c2..402f282 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -195,7 +195,6 @@ CONFIG_USB_EHCI_MXC=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_CHIPIDEA=y
>  CONFIG_USB_CHIPIDEA_HOST=y
> -CONFIG_USB_PHY=y
>  CONFIG_NOP_USB_XCEIV=y
>  CONFIG_USB_MXS_PHY=y
>  CONFIG_MMC=y
> -- 
> 1.8.1.2
> 
