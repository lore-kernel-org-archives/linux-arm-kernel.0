From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 29 Mar 2013 13:49:15 -0400 (EDT)
Subject: [PATCH v3 1/7] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <1364507705-22012-2-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1303291342540.1467-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Mar 2013, Arnd Bergmann wrote:

> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> Separate the Orion host controller driver from ehci-hcd host
> code into its own driver module because of following reason.
...

On the whole this patch is good.

> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -163,6 +163,16 @@ config USB_EHCI_HCD_OMAP
>  	  Enables support for the on-chip EHCI controller on
>  	  OMAP3 and later chips.
>  
> +config USB_EHCI_HCD_ORION
> +	tristate  "Support for Marvell EBU on-chip EHCI USB controller"
> +	depends on USB_EHCI_HCD && PLAT_ORION
> +	default y
> +	---help---
> +	  Enables support for the on-chip EHCI controller on Marvell's
> +	  embedded ARM SoCs, including Orion, Kirkwood, Dove, Armada XP,
> +	  Armada 370.  This is different from the EHCI implementation
> +	  on Marvell's mobile PXA and MMP SoC, see USB_EHCI_MV for those.

I don't know about this last phrase.  When someone is running "make 
menuconfig", for example, what shows up is the symbol's description, 
not the symbol's name.  That person would see "EHCI support for Marvell 
on-chip controller", not "USB_EHCI_MV".

In fact, shouldn't the description for USB_EHCI_MV be changed too, to 
make it more distinct from this one?

All the code changes are fine.

Alan Stern
