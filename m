From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 22 Apr 2014 15:58:09 -0400
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with missing
 memory barrier
In-Reply-To: <201404222153.41786.arnd@arndb.de>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <201404221608.36628.arnd@arndb.de> <53567E7C.7020409@ti.com>
 <201404222153.41786.arnd@arndb.de>
Message-ID: <5356C9D1.2060001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 April 2014 03:53 PM, Arnd Bergmann wrote:
> On Tuesday 22 April 2014, Santosh Shilimkar wrote:
>> On Tuesday 22 April 2014 10:08 AM, Arnd Bergmann wrote:
>>> It's not the nicest API ever, but that's what it is and has been, mostly
>>> for compatibility with x86, where the 'mov' instruction performing the
>>> store to MMIO registers implies that all writes to DMA memory are
>>> visible to the device.
>>>
>> This is not about writel() and  writel_relaxed(). The driver don't
>> need that barrier. For example if the actual start of the DMA
>> happens bit later, that doesn't matter for the driver.
>>
>> DMA APIs already do barriers today for non-coherent case. We
>> are not talking anything new here. Sorry but I don't see the
>> connection here.
> 
> I don't think they do, nor should they. Can you tell me where
> you see a barrier in dma_sync_single_for_cpu() or 
> arm_dma_sync_single_for_device()? For all I can tell, they
> only deal with L1 and L2 cache maintainance in arm_dma_ops.
> 
The cache APIs used by dma_ops do have the necessary barriers
at end of the of the cache operations. Thats what I meant. So for
end user(Device driver), its transparent.

Regards,
Santosh
