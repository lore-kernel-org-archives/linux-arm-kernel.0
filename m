From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 11 Jul 2018 19:03:55 +0100
Subject: [RFC PATCH 2/4] ACPI/IORT: Set bus DMA mask as appropriate
In-Reply-To: <20180710180458.GC26285@lst.de>
References: <cover.1531239284.git.robin.murphy@arm.com>
 <c604b3eae4103ee0ad6da84baa1bc893a81ef5f8.1531239284.git.robin.murphy@arm.com>
 <20180710180458.GC26285@lst.de>
Message-ID: <da218bdf-198e-b064-356d-3354869a670a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/18 19:04, Christoph Hellwig wrote:
> On Tue, Jul 10, 2018 at 06:17:17PM +0100, Robin Murphy wrote:
>> When an explicit DMA limit is described by firmware, we need to remember
>> it regardless of how drivers might subsequently update their devices'
>> masks. The new bus_dma_mask field does that.
> 
> Shouldn't we also stop presetting the dma mask after this?

I guess initialising the device masks here only really has any effect if 
drivers fail to set their own, so if we're getting stricter about that 
then it would make sense to stop; I'll add a couple of patches on top to 
clean that up.

Robin.
