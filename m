From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Aug 2014 14:14:45 +0100
Subject: [PATH V2 1/6] mm: Introduce a general RCU get_user_pages_fast.
In-Reply-To: <20140827125027.GA7765@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-2-git-send-email-steve.capper@linaro.org>
 <20140827085442.GD16376@arm.com> <20140827125027.GA7765@linaro.org>
Message-ID: <20140827131445.GB17601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 01:50:28PM +0100, Steve Capper wrote:
> On Wed, Aug 27, 2014 at 09:54:42AM +0100, Will Deacon wrote:
> > On Thu, Aug 21, 2014 at 04:43:27PM +0100, Steve Capper wrote:
> > > @@ -672,3 +676,277 @@ struct page *get_dump_page(unsigned long addr)
> > >  	return page;
> > >  }
> > >  #endif /* CONFIG_ELF_CORE */
> > > +
> > > +#ifdef CONFIG_HAVE_RCU_GUP
> > > +
> > > +#ifdef __HAVE_ARCH_PTE_SPECIAL
> > 
> > Do we actually require this (pte special) if hugepages are disabled or
> > not supported?
> 
> We need this logic if we want use fast_gup on normal pages safely. The special
> bit indicates that we should not attempt to take a reference to the underlying
> page.
> 
> Huge pages are guaranteed not to be special.

Gah, I somehow mixed up sp-litting and sp-ecial. Step away from the
computer.

In which case, the patch looks fine. You might need to repost with '[PATCH]'
instead of '[PATH]', in case you confused people's filters.

Will
