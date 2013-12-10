From: rogerq@ti.com (Roger Quadros)
Date: Tue, 10 Dec 2013 08:39:25 +0530
Subject: [PATCH v3 2/2] usb: phy: Add keystone usb phy driver
In-Reply-To: <1386627424-373-3-git-send-email-w-kwok2@ti.com>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
 <1386627424-373-3-git-send-email-w-kwok2@ti.com>
Message-ID: <52A685E5.9060604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 03:47 AM, WingMan Kwok wrote:
> Add Keystone platform USB PHY driver support. Current main purpose
> of this driver is to enable the PHY reference clock gate on the
> Keystone SoC. Otherwise it is a nop PHY.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>  drivers/usb/phy/Kconfig        |   10 +++
>  drivers/usb/phy/Makefile       |    1 +
>  drivers/usb/phy/phy-keystone.c |  142 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 153 insertions(+)
>  create mode 100644 drivers/usb/phy/phy-keystone.c
> 
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index 08e2f39..c6792f43 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -40,6 +40,16 @@ config ISP1301_OMAP
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called isp1301_omap.
>  
> +config KEYSTONE_USB_PHY
> +	tristate "Keystone USB PHY Driver"
> +	depends on ARCH_KEYSTONE
> +	select USB_PHY

NOP_USB_XCEIV selects USB_PHY so not necessary.

> +	select NOP_USB_XCEIV
> +	help
> +	  Enable this to support Keystone USB phy. This driver provides
> +	  interface to interact with USB 2.0 and USB 3.0 PHY that is part
> +	  of the Keystone SOC.
> +
>  config MV_U3D_PHY
>  	bool "Marvell USB 3.0 PHY controller Driver"
>  	depends on CPU_MMP3
> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
> index 022c1da..311b47b 100644
> --- a/drivers/usb/phy/Makefile
> +++ b/drivers/usb/phy/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_USB_RCAR_PHY)		+= phy-rcar-usb.o
>  obj-$(CONFIG_USB_RCAR_GEN2_PHY)		+= phy-rcar-gen2-usb.o
>  obj-$(CONFIG_USB_ULPI)			+= phy-ulpi.o
>  obj-$(CONFIG_USB_ULPI_VIEWPORT)		+= phy-ulpi-viewport.o
> +obj-$(CONFIG_KEYSTONE_USB_PHY)		+= phy-keystone.o

cheers,
-roger
