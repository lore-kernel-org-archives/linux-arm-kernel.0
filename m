From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 4 Feb 2013 16:03:10 -0500 (EST)
Subject: [PATCH 31/31] USB: ehci-omap: Select NOP USB transceiver driver
In-Reply-To: <1359989205-12879-1-git-send-email-rogerq@ti.com>
Message-ID: <Pine.LNX.4.44L0.1302041602350.1756-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Feb 2013, Roger Quadros wrote:

> In PHY mode we need to have the nop-usb-xceiv transceiver
> driver to operate, so select it in Kconfig.
> 
> CC: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/host/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 11e102e..2d2975d 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -157,6 +157,7 @@ config USB_EHCI_MXC
>  config USB_EHCI_HCD_OMAP
>  	tristate "EHCI support for OMAP3 and later chips"
>  	depends on USB_EHCI_HCD && ARCH_OMAP
> +	select NOP_USB_XCEIV
>  	default y
>  	---help---
>  	  Enables support for the on-chip EHCI controller on

Acked-by: Alan Stern <stern@rowland.harvard.edu>
