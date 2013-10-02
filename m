From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Oct 2013 18:07:48 +0100
Subject: [PATCH v6 10/19] xen: introduce xen_alloc/free_coherent_pages
In-Reply-To: <alpine.DEB.2.02.1310021754580.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1309271653420.5498@kaball.uk.xensource.com>
 <1380298207-29151-10-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130930153143.GQ3106@phenom.dumpdata.com>
 <DB675896-3FF2-409B-A2C6-24295C197A3F@arm.com>
 <alpine.DEB.2.02.1310021754580.26077@kaball.uk.xensource.com>
Message-ID: <20131002170747.GG29794@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 06:03:46PM +0100, Stefano Stabellini wrote:
> On Tue, 1 Oct 2013, Catalin Marinas wrote:
> > On 30 Sep 2013, at 16:31, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> > > On Fri, Sep 27, 2013 at 05:09:58PM +0100, Stefano Stabellini wrote:
> > >> xen_swiotlb_alloc_coherent needs to allocate a coherent buffer for cpu
> > >> and devices. On native x86 and ARMv8 is sufficient to call
> > >> __get_free_pages in order to get a coherent buffer, while on ARM we need
> > >> to call the native dma_ops->alloc implementation.
> > >> 
> > >> When arm64 stops using the swiotlb by default and starts having multiple
> > >> dma_ops implementations, we'll use __get_dma_ops there too.
> > > 
> > > I presume this is a future TODO, not some further patch (in which
> > > case you should say in here the title of it). If it is a TODO could
> > > you stick that in the sentence here somewhere to make it crytal clear that
> > > it is not implemented.
> > 
> > Thanks for pointing this out.  The arm64 patch shouldn't be different
> > from arm here.  I thought a subsequent patch already added
> > __get_dma_ops() for arm64.
> 
> Yes, the arm64 patch already added __get_dma_ops.
> 
> However I am not using __get_dma_ops to implement
> xen_alloc_coherent_pages for arm64 because I can just use
> __get_free_pages for the moment:

So why do the work twice when we'll get coherency maintenance in the DMA
ops?

-- 
Catalin
