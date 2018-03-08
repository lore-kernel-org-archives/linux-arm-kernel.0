From: willy@infradead.org (Matthew Wilcox)
Date: Thu, 8 Mar 2018 14:07:08 -0800
Subject: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
In-Reply-To: <1520527285.2693.56.camel@hpe.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
 <20180307183227.17983-2-toshi.kani@hpe.com>
 <20180308040016.GB9082@bombadil.infradead.org>
 <1520527285.2693.56.camel@hpe.com>
Message-ID: <20180308220708.GA29073@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 03:56:30PM +0000, Kani, Toshi wrote:
> On Wed, 2018-03-07 at 20:00 -0800, Matthew Wilcox wrote:
> > On Wed, Mar 07, 2018 at 11:32:26AM -0700, Toshi Kani wrote:
> > > +/**
> > > + * pud_free_pmd_page - clear pud entry and free pmd page
> > > + *
> > > + * Returns 1 on success and 0 on failure (pud not cleared).
> > > + */
> > > +int pud_free_pmd_page(pud_t *pud)
> > > +{
> > > +	return pud_none(*pud);
> > > +}
> > 
> > Wouldn't it be clearer if you returned 'bool' instead of 'int' here?
> 
> I thought about it and decided to use 'int' since all other pud/pmd/pte
> interfaces, such as pud_none() above, use 'int'.

These interfaces were introduced before we had bool ... I suspect nobody's
taken the time to go through and convert them all.
