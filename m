From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Fri, 6 Sep 2013 10:17:54 -0400
Subject: [PATCH v5 12/13] swiotlb-xen: use xen_alloc/free_coherent_pages
In-Reply-To: <alpine.DEB.2.02.1309051743450.6397@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1308291917290.6397@kaball.uk.xensource.com>
 <1377801154-29215-12-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130830135333.GL21239@phenom.dumpdata.com>
 <alpine.DEB.2.02.1309051743450.6397@kaball.uk.xensource.com>
Message-ID: <20130906141754.GT2590@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 05, 2013 at 05:50:45PM +0100, Stefano Stabellini wrote:
> On Fri, 30 Aug 2013, Konrad Rzeszutek Wilk wrote:
> > On Thu, Aug 29, 2013 at 07:32:33PM +0100, Stefano Stabellini wrote:
> > > Use xen_alloc_coherent_pages and xen_free_coherent_pages to allocate or
> > > free coherent pages.
> > > 
> > > We need to be careful handling the pointer returned by
> > > xen_alloc_coherent_pages, because on ARM the pointer is not equal to
> > > phys_to_virt(*dma_handle). In fact virt_to_phys on the returned pointer
> > > doesn't return a valid physical address.
> > 
> > Why is it called 'virt_to_phys'? What does it return then?
> 
> virt_to_phys only works for kernel direct mapped RAM memory.
> In this case the virtual address could be an ioremap address, therefore
> passing it to virt_to_phys would give you another physical address that
> doesn't correspond to it.

Ah, so very much ARM (and in some way SPARC) specific. I think you need add some comments
in the code (And git commit) to explain this. Thank you.
