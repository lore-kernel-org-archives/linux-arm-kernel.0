From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Apr 2015 12:41:30 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <5540B35C.4050002@topic.nl>
References: <5538DD02.6050401@topic.nl> <2919263.vEuyzce5K7@wuerfel>
 <5540B35C.4050002@topic.nl>
Message-ID: <3382997.5hgfVKmNXP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 April 2015 12:33:00 Mike Looijmans wrote:
> On 29-04-15 12:07, Arnd Bergmann wrote:
> > On Wednesday 29 April 2015 11:47:37 Mike Looijmans wrote:
> >> On 29-04-15 11:17, Russell King - ARM Linux wrote:
> >>> The buffer should also be mapped into userspace with the same memory
> >>> type and cache attributes as the kernel side mapping.  If using ACP,
> >>> then you probably want "normal memory, cacheable, writeback, read
> >>> allocate" or in the case of SMP, the same but "read/write allocate".
> >
> > If my suspicion is correct, we should either change arm_coherent_dma_ops()
> > to refer to a different mmap() callback that does the right thing for
> > coherent devices, or change arm_dma_mmap() to look at dev->is_coherent.
> 
> Following the route, arch/arm/mm/dma-mapping.c uses pgprot_dmacoherent() which 
> is defined in arch/arm/include/asm/pgtable.h and that just returns uncached 
> memory.
> 
> If you can give me some hints as to what the correct flags would be, I can 
> patch my kernel and test it.

Use the flags that Russell listed above.

	Arnd
