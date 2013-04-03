From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 3 Apr 2013 13:25:49 +0000
Subject: [RFC PATCH] at_hdmac: move to generic DMA binding
In-Reply-To: <1364994863-7347-1-git-send-email-=ludovic.desroches@atmel.com>
References: <1364994863-7347-1-git-send-email-=ludovic.desroches@atmel.com>
Message-ID: <201304031325.49813.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 April 2013, =ludovic.desroches at atmel.com wrote:
> +
> +DMA clients connected to the Atmel DMA controller must use the format
> +described in the dma.txt file, using a four-cell specifier for each channel.
> +The four cells in order are:
> +
> +1. A phandle pointing to the DMA controller
> +2. The memory interface (16 most significant bits), the peripheral interface
> +(16 less significant bits)
> 
> Most of our products have only one memory interface which is the interface 0
> from the dma controller point of view. The SAMA5D3 family is the only one to
> have two memory interfaces (0 and 1) so the peripheral interface is interface 2
> instead of interface 1.
> Since it will concern only one device family, I think it is better to put both
> interfaces in the same cell.

Seems reasonable.

> +3. The peripheral identifier (can be different for tx and rx)
> +4. The chunk transfer size, must be 1, 4, 8 or 16

I wonder if the chunk transfer size should instead be set using
dmaengine_slave_config(). Is this something that you need to have
configured at the platform level, or can it be hardcoded into the
slave driver independent of where that slave is being used?

	Arnd
