From: r.sricharan@ti.com (Sricharan R)
Date: Fri, 17 Jan 2014 19:53:26 +0530
Subject: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
In-Reply-To: <20140113141713.GC27282@n2100.arm.linux.org.uk>
References: <20140102150621.GJ16456@n2100.arm.linux.org.uk>
 <52CFE494.4010702@ti.com> <20140113141713.GC27282@n2100.arm.linux.org.uk>
Message-ID: <52D93CDE.4010101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 January 2014 07:47 PM, Russell King - ARM Linux wrote:
> On Fri, Jan 10, 2014 at 05:46:20PM +0530, Sricharan R wrote:
>> I tested this series on DRA7 with mmc peripheral dma and it looked
>> fine. Some how dmaengine test cases were not fine. But that may not
>> have anything to do with this series. I will check more on that and
>> will come back with that results as well.
> 
> Not fine in what sense?
> 
Sorry for delayed response.

So in the case of dmaengine test case, it looks for channels
with DMA_MEMCPY, DMA_XOR, DMA_PQ capabilities. But the omap-dma
 device is not registered with MEMCPY capabilities, hence the
testcase fails as no channels are available.

Regards,
 Sricharan
