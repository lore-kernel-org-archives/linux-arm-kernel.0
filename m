From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 25 Apr 2018 08:17:45 -0700
Subject: [PATCH v2 5/5] ARM: Unconditionally enable ARM_DMA_USE_IOMMU
In-Reply-To: <20180425102511.GP16141@n2100.armlinux.org.uk>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425101051.15349-5-thierry.reding@gmail.com>
 <20180425102511.GP16141@n2100.armlinux.org.uk>
Message-ID: <20180425151745.GA16075@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 11:25:11AM +0100, Russell King - ARM Linux wrote:
> >  config ARM_DMA_USE_IOMMU
> > -	bool
> > +	def_bool y
> >  	select ARM_HAS_SG_CHAIN
> >  	select NEED_SG_DMA_LENGTH
> 
> This doesn't work - as has recently been discussed with hch, we can't
> globally enable NEED_SG_DMA_LENGTH on ARM - the ARM architecture
> pre-dates the addition of the DMA length member in the scatterlist,
> and not every machine supports the splitting of the DMA length from
> the non-DMA length member.  Hence, this will cause a regression,
> sorry.

Agreed as-is.  However supporting it everywhere should not be much work,
I'll take a look at it.
