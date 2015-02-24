From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 24 Feb 2015 19:01:41 +0200
Subject: [PATCH 5/6] dmaengine: omap-dma: Remove mapping between virtual
 channels and requests
In-Reply-To: <20150224142833.GI8670@n2100.arm.linux.org.uk>
References: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>
 <1424787683-19151-6-git-send-email-peter.ujfalusi@ti.com>
 <20150224142833.GI8670@n2100.arm.linux.org.uk>
Message-ID: <54ECAE75.3070501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2015 04:28 PM, Russell King - ARM Linux wrote:
> On Tue, Feb 24, 2015 at 04:21:22PM +0200, Peter Ujfalusi wrote:
>> Do not direct map the virtual channels to sDMA request number. When the
>> sDMA is behind of a crossbar this direct mapping can cause situations when
>> certain channel can not be requested since the crossbar request number
>> will no longer match with the sDMA request line.
>> The direct mapping for virtual channels with HW request lines will make it
>> harder to implement MEM_TO_MEM mode for the driver.
> 
> I assume when you talk about MEM_TO_MEM, you're referring to a DMA_MEMCPY
> driver.
> 
> mem2mem should not be handled by the slave driver.  This should be a
> separate DMA engine driver structure which does not have DMA_SLAVE set.
> 
> See how amba-pl08x handles this.

Thanks for the pointer. I'm just planning to add the DMA_MEMCPY support for
omap-dma. With that in place we can convert the remaining legacy API users to
use dmaengine (as I recall all of them are using DMA for memcopy)

-- 
P?ter
