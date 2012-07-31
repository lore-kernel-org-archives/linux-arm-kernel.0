From: clemens@ladisch.de (Clemens Ladisch)
Date: Tue, 31 Jul 2012 08:59:21 +0200
Subject: About dma_sync_single_for_{cpu,device}
In-Reply-To: <20120731064557.GA4676@gobelin>
References: <20120730202401.GA4947@gobelin> <20120731064557.GA4676@gobelin>
Message-ID: <50178249.7090306@ladisch.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Karl Beldan wrote:
> To tx a chunk of data from the SoC => network device, we :
> - prepare a buffer with a leading header embedding a pattern,
> - trigger the xfer and wait for an irq
> // The device updates the pattern and then triggers an irq
> - upon irq we check the pattern for the xfer completion
>
> I was expecting the following to work:
> 	addr = dma_map_single(dev, buffer, size, DMA_TO_DEVICE);

Of both the CPU and the device write to the buffer, you must use
DMA_BIDIRECTIONAL.


Regards,
Clemens
