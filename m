From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 May 2015 13:56:45 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <554B49F0.1090100@topic.nl>
References: <5538DD02.6050401@topic.nl> <9622793.RaVBbeJMCx@wuerfel>
 <554B49F0.1090100@topic.nl>
Message-ID: <32427108.CqIsMKEeGj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 May 2015 13:18:08 Mike Looijmans wrote:
> On 29-04-15 15:13, Arnd Bergmann wrote:
> > On Wednesday 29 April 2015 14:49:26 Mike Looijmans wrote:
> >> Avoiding the streaming mapping and using only the coherent modes prevents the
> >> system locking up, it then doesn't do more harm than just corrupting data in
> >> the buffers.
> >
> > If I understand it right, you basically just skip the 'vma->vm_page_prot =
> > __get_dma_pgprot(attrs, vma->vm_page_prot);' step and get the right mapping
> > here, i.e. the pgprot value we use for all normal memory.
> 
> I reverted all my patches and workarounds. Indeed, the kernel needs a 
> "coherent" version of the dma_mmap routine, as the current version will map it 
> as non-cachable, resulting in a big performance hit (and nullifying the whole 
> idea behind it).
> 
> I'll test it further on my 'hardware' and cook up a patch that correctly maps 
> the coherent pages.
> 

Ok, thanks!

	Arnd
