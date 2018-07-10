From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 10 Jul 2018 19:11:38 +0100
Subject: [RFC PATCH 0/4] Stop losing firmware-set DMA masks
In-Reply-To: <20180710180232.GA26285@lst.de>
References: <cover.1531239284.git.robin.murphy@arm.com>
 <20180710180232.GA26285@lst.de>
Message-ID: <89365af4-19fa-1dc2-27d0-37e9145134af@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/18 19:02, Christoph Hellwig wrote:
>> These patches attempt to deal with this in the simplest way possible by
>> generalising the specific quirk for 32-bit bridges into an arbitrary
>> mask which can then also be plumbed into the firmware code. In the
>> interest of being minimally invasive, I've only included a point fix
>> for the IOMMU issue as seen on arm64 - there may be further tweaks
>> needed in DMA ops to catch all possible incarnations of this problem,
>> but this initial RFC is mostly about the impact beyond the dma-mapping
>> subsystem itself.
> 
> Thanks, this looks very nice to me.
> 
> In fact it probably solves the RISC-V/Xiling problem as well if we can
> just add the dma-ranges property to the device tree for the affected
> systems.  Palmer, do you know how easily the DT could be updated for
> that case?

That would indeed be nice, but beware that the way PCI devices are 
bodged through of_dma_configure() only actually works for dma-coherent 
and is busted WRT parsing dma-ranges correctly. Fixing that is my next 
step after getting these basics done ;)

Robin.
