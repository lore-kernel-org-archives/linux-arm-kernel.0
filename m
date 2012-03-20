From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Mar 2012 13:03:10 +0000
Subject: [PATCH v2 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre@atmel.com>
References: <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre@atmel.com>
Message-ID: <201203201303.11175.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 March 2012, Nicolas Ferre wrote:
> 
> Add some basic helpers to retrieve a DMA controller device_node and the
> DMA request specifications. By making DMA controllers register a generic
> translation function, we allow the management of any type of DMA requests
> specification.
> The void * output of an of_dma_xlate() function that will be implemented
> by the DMA controller can carry any type of "dma-request" argument.
> 
> The DMA client will search its associated DMA controller in the list and
> call the registered of_dam_xlate() function to retrieve the request values.
> 
> One simple xlate function is provided for the "single number" type of
> request binding.
> 
> This implementation is independent from dmaengine so it can also be used
> by legacy drivers.

Thanks a lot of posting this updated version, I think it will be very
useful as we proceed. I still hope that in the end we find that the
differences are not all that big and we can do it all with bindings
very much like what you have here.

	Arnd
