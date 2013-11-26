From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 Nov 2013 09:54:25 -0600
Subject: [PATCH] phy: kconfig: add depends on "USB_SUPPORT" to OMAP_USB2
 and TWL4030_USB
In-Reply-To: <1385460115-31194-1-git-send-email-kishon@ti.com>
References: <1385460115-31194-1-git-send-email-kishon@ti.com>
Message-ID: <20131126155425.GC24310@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 03:31:55PM +0530, Kishon Vijay Abraham I wrote:
> Fixes
> warning: (OMAP_USB2 && TWL4030_USB) selects USB_PHY which has unmet
> direct dependencies (USB_SUPPORT)
> that shows up while disabling USB_SUPPORT from menuconfig.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index a344f3d..0c87e4c 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -24,6 +24,7 @@ config PHY_EXYNOS_MIPI_VIDEO
>  config OMAP_USB2
>  	tristate "OMAP USB2 PHY Driver"
>  	depends on ARCH_OMAP2PLUS
> +	depends on USB_SUPPORT
>  	select GENERIC_PHY
>  	select USB_PHY
>  	select OMAP_CONTROL_USB
> @@ -36,6 +37,7 @@ config OMAP_USB2
>  config TWL4030_USB
>  	tristate "TWL4030 USB Transceiver Driver"
>  	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
> +	depends on USB_SUPPORT

The problem is actually the select below. Make this driver depend on
GENERIC_PHY instead. Note that we have to remove that dependency soonish
as this same IP is used as a SATA PHY.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/710cfbbd/attachment.sig>
