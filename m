From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 11 Apr 2017 15:31:39 +0100
Subject: [PATCH v3 04/32] asm-generic: add ioremap_nopost() remap interface
In-Reply-To: <1491917983.7236.9.camel@kernel.crashing.org>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
 <1491917983.7236.9.camel@kernel.crashing.org>
Message-ID: <20170411143138.GC6821@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 11:39:43PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-04-11 at 13:28 +0100, Lorenzo Pieralisi wrote:
> > +static inline void __iomem *ioremap_nopost(phys_addr_t offset,
> > size_t size)
> > +{
> > +???????return ioremap_nocache(offset, size);
> > +}
> > +
> 
> No this is wrong as I explained.
> 
> This is a semantic that simply *cannot* be generically provided accross
> architectures as a mapping attribute.

I agree that a default implementation does not make much sense. The
only solution to this, if we want the ioremap_nopost to be made available
to generic code (and drivers - ie DT PCI host bridge drivers on ARM/ARM64
are not arch code), is to make the ioremap_nopost() call return NULL
unless overriden by arch code that can provide its semantics.

Thanks,
Lorenzo
