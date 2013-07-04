From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 4 Jul 2013 16:36:46 -0400 (EDT)
Subject: [PATCH 2/2] USB: OHCI: make ohci-pxa27x a separate driver
In-Reply-To: <1372958187-4039-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1307041633370.26847-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Jul 2013, Manjunath Goudar wrote:

> Separate the  OHCI pxa27x/pxa3xx host controller driver from
> ohci-hcd host code so that it can be built as a separate driver
> module. This work is part of enabling multi-platform kernels on
> ARM.

> +config USB_OHCI_HCD_PXA27X
> +	tristate "Support for PXA27X/PXA3XX on-chip OHCI USB controller"
> +	depends on USB_OHCI_HCD && ARCH_PXA

Shouldn't the ARCH_PXA part be the same as ...

> @@ -1184,11 +1184,6 @@ MODULE_LICENSE ("GPL");
>  #define SA1111_DRIVER		ohci_hcd_sa1111_driver
>  #endif
>  
> -#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)

... this?

> diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
> index 5fb91f1..791e2b5 100644
> --- a/drivers/usb/host/ohci-pxa27x.c
> +++ b/drivers/usb/host/ohci-pxa27x.c

Several aspects of this are strange.  For example, consider how you 
used the private part of the ohci_hcd structure and how the variable 
names are inconsistent with the other OHCI glue drivers.

Alan Stern
