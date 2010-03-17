From: budheej@gmail.com (Budhee Jamaich)
Date: Wed, 17 Mar 2010 10:02:09 +0200
Subject: mapping uncached memory
In-Reply-To: <20100316235422.GC13948@n2100.arm.linux.org.uk>
References: <57314e841003161617l53dc3a50la969369f0161ccdd@mail.gmail.com>
	<20100316235422.GC13948@n2100.arm.linux.org.uk>
Message-ID: <57314e841003170102y2b2634f1na9c18282f344d3c2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 1:54 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> 3. use dma_alloc_coherent in some way
>>
>> cons: documentation says we still need to use cache clean/inv

> Please provide a pointer to that documentation.


from Documentation/DMA-API.txt:

"void *
dma_alloc_coherent(struct device *dev, size_t size,
                             dma_addr_t *dma_handle, gfp_t flag)

Consistent memory is memory for which a write by either the device or
the processor can immediately be read by the processor or device
without having to worry about caching effects.  (You may however need
to make sure to flush the processor's write buffers before telling
devices to read that memory.)"



That last sentence - what does it really say ? That I still need to
manually clean/invalidate the caches myself ?



By reading consistent_init() I couldn't find any magic that makes the
memory uncached. Can you please tell me how the uncached property of
the memory is assured ?


thank you
budhee
