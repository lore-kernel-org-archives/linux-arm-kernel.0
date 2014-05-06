From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 May 2014 13:34:46 +0200
Subject: [PATCH v3 06/20] usb: host: xhci-plat: Add support for the Armada
 38x
In-Reply-To: <1399335255-589-7-git-send-email-gregory.clement@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <1399335255-589-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1584794.IM1uiSkBdk@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Tuesday, May 06, 2014 02:14:01 AM Gregory CLEMENT wrote:
> For the Armada 38x SoCs which come with an xhci controller, specific
> initialization must be done during probe related to the MBus windows
> configuration. This patch adds the support of this quirk.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/usb/host/Kconfig      |  7 +++++
>  drivers/usb/host/Makefile     |  1 +
>  drivers/usb/host/xhci-mvebu.c | 71 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-mvebu.h | 21 +++++++++++++
>  drivers/usb/host/xhci-plat.c  |  6 ++++
>  5 files changed, 106 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-mvebu.c
>  create mode 100644 drivers/usb/host/xhci-mvebu.h
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 3d9e54062d62..e70943fac4a1 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -29,6 +29,13 @@ if USB_XHCI_HCD
>  config USB_XHCI_PLATFORM
>  	tristate
>  
> +config USB_XHCI_MVEBU
> +	tristate "xHCI support for Marvell Armada 38x"

Please limit this driver to mvebu arch and compile testing, i.e.

	depends on ARCH_MVEBU || COMPILE_TEST

> +	select USB_XHCI_PLATFORM
> +	---help---
> +	  Say 'Y' to enable the support for the xHCI host controller
> +	  found in Marvell Armada 38x ARM SOCs.
> +
>  endif # USB_XHCI_HCD
>  
>  config USB_EHCI_HCD

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
