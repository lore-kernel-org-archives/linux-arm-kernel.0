From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 09 Jun 2010 13:17:43 -0400 (EDT)
Subject: [PATCH] [kirkwood-otg] Leverage the Freescale OTG driver for
	Kirkwood OTG
In-Reply-To: <1276094138-13497-2-git-send-email-jason.mcmullan@netronome.com>
References: <1276094138-13497-1-git-send-email-jason.mcmullan@netronome.com>
	<1276094138-13497-2-git-send-email-jason.mcmullan@netronome.com>
Message-ID: <alpine.LFD.2.00.1006091307321.30664@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jun 2010, Jason S. McMullan wrote:

> The Freescale USB Gadget driver is based off of the
> same USB OTG core that is used in the Kirkwood.
> 
> NOTE: Your bootloader must ensure that the Kirkwood
>       USB 2.0 Bridge Window registers are set correctly,
>       or the driver will stall on the first DMA.

Could you add the code to sets that up in the kernel instead?  

> @@ -156,7 +156,7 @@ config USB_ATMEL_USBA
>  
>  config USB_GADGET_FSL_USB2
>  	boolean "Freescale Highspeed USB DR Peripheral Controller"
> -	depends on FSL_SOC || ARCH_MXC
> +	depends on FSL_SOC || ARCH_MXC || ARCH_KIRKWOOD
>  	select USB_GADGET_DUALSPEED
>  	help
>  	   Some of Freescale PowerPC processors have a High Speed

Maybe the help text should be extended to mention Kirkwood?


Nicolas
