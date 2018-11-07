From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Nov 2018 09:03:35 +0100
Subject: [PATCH] of/device: Really only set bus DMA mask when appropriate
In-Reply-To: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
Message-ID: <20181107080335.GA24511@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 11:54:15AM +0000, Robin Murphy wrote:
> of_dma_configure() was *supposed* to be following the same logic as
> acpi_dma_configure() and only setting bus_dma_mask if some range was
> specified by the firmware. However, it seems that subtlety got lost in
> the process of fitting it into the differently-shaped control flow, and
> as a result the force_dma==true case ends up always setting the bus mask
> to the 32-bit default, which is not what anyone wants.
> 
> Make sure we only touch it if the DT actually said so.

This looks good, but I think it could really use a comment as the use
of ret all the way down the function isn't exactly obvious.

Let me now if you want this picked up through the OF or DMA trees.
