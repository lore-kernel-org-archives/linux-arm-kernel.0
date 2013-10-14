From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 15 Oct 2013 09:01:16 +1100
Subject: [PATCH] usb: ohci: remove ep93xx bus glue platform driver
In-Reply-To: <201310141435.31147.hartleys@visionengravers.com>
References: <201310141435.31147.hartleys@visionengravers.com>
Message-ID: <525C69AC.1010004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/13 08:35, H Hartley Sweeten wrote:
> Convert ep93xx to use the OHCI platform driver and remove the
> ohci-ep93xx bus glue driver.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ryan Mallon <rmallon@gmail.com>
> ---

> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index b3f20d7..2c8f2db 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -472,7 +472,7 @@ config USB_CNS3XXX_OHCI
>  
>  config USB_OHCI_HCD_PLATFORM
>  	tristate "Generic OHCI driver for a platform device"
> -	default n
> +	default y if ARCH_EP93XX

Shouldn't we select USB_OHCI_HCD_PLATFORM, e.g. something like:

	config ARCH_EP93XX_USB
		tristate "USB OHCI support"
		default y
		select USB_OHCI_HCD_PLATFORM

In arch/arm/mach-ep93xx/Kconfig rather than polluting
drivers/usb/host/Kconfig with arch specific stuff?

~Ryan
