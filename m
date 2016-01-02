From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Sat, 02 Jan 2016 12:10:20 -0800
Subject: [Question about DMA] Consistent memory?
In-Reply-To: <56881874.4050907@topic.nl>
References: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>
 <20160102103948.GR8644@n2100.arm.linux.org.uk> <56881874.4050907@topic.nl>
Message-ID: <1451765420.2323.6.camel@HansenPartnership.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2016-01-02 at 19:35 +0100, Mike Looijmans wrote:
> On 2-1-2016 11:39, Russell King - ARM Linux wrote:
> > On Thu, Dec 31, 2015 at 04:50:54PM +0900, Masahiro Yamada wrote:
> > > Hi.
> > > 
> > > I am new to the Linux DMA APIs.
> > > 
> > > First, I started by reading Documentation/DMA-API.txt,
> > > but I am confused with the term "consistent memory".
> > 
> > Just read "coherent memory" instead - the documentation confusingly
> > uses
> > the two terms to refer to the same thing.  I think there was a
> > patch a
> > while back to replace "consistent" with "coherent" in this
> > document,
> > though I'm not sure what happened to it.
> 
> I wrote that patch. I never got any comments on it, so either I
> didn't 
> post it to the right people, or no one really cares:
> http://www.kernelhub.org/?msg=747166&p=2
> 
> I still think that if the kernel methods all have "coherent" in their
> name, we should use the word "coherent" in the documentation as well,
> and not confuse people even further. So I'd happily repost that 
> patch.

They don't: the PCI API still uses consistent:

asm-generic/pci-dma-compat.h:pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
asm-generic/pci-dma-compat.h:pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
asm-generic/pci-dma-compat.h:pci_free_consistent(struct pci_dev *hwdev, size_t size,
asm-generic/pci-dma-compat.h:static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
linux/pci.h:/* kmem_cache style wrapper around pci_alloc_consistent() */
linux/pci.h:static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)

These are named based on the PCI specification.

James
