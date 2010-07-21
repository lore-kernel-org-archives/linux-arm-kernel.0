From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 21 Jul 2010 13:15:14 +0530
Subject: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
	memory management
In-Reply-To: <20100721072837.GB6009@n2100.arm.linux.org.uk>
References: <20100714220536.GE18138@n2100.arm.linux.org.uk>
	<20100715012958.GB2239@codeaurora.org>
	<20100715085535.GC26212@n2100.arm.linux.org.uk>
	<AANLkTinVZeaZxt_lWKhjKa0dqhu3_j3BRNySO-2LvMdw@mail.gmail.com>
	<20100716075856.GC16124@n2100.arm.linux.org.uk>
	<4C449183.20000@codeaurora.org>
	<20100719184002.GA21608@n2100.arm.linux.org.uk>
	<bb667e285fd8be82ea8cc9cc25cf335b.squirrel@www.codeaurora.org>
	<20100720222952.GD10553@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C61C5FCA@dbde02.ent.ti.com>
	<20100721072837.GB6009@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C61C60DD@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Wednesday, July 21, 2010 12:59 PM
> To: Shilimkar, Santosh
> Cc: stepanm at codeaurora.org; linux-arch at vger.kernel.org;
> dwalker at codeaurora.org; mel at csn.ul.ie; linux-arm-msm at vger.kernel.org;
> linux-kernel at vger.kernel.org; FUJITA Tomonori; linux-mm at kvack.org;
> andi at firstfloor.org; Zach Pfeffer; Michael Bohan; Tim HRM; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> ebiederm at xmission.com
> Subject: Re: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
> memory management
> 
> On Wed, Jul 21, 2010 at 11:19:58AM +0530, Shilimkar, Santosh wrote:
> > > -----Original Message-----
> > > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > > kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM
> Linux
> > > Sent: Wednesday, July 21, 2010 4:00 AM
> > > To: stepanm at codeaurora.org
> > > Cc: linux-arch at vger.kernel.org; dwalker at codeaurora.org; mel at csn.ul.ie;
> > > linux-arm-msm at vger.kernel.org; linux-kernel at vger.kernel.org; FUJITA
> > > Tomonori; linux-mm at kvack.org; andi at firstfloor.org; Zach Pfeffer;
> Michael
> > > Bohan; Tim HRM; linux-omap at vger.kernel.org; linux-arm-
> > > kernel at lists.infradead.org; ebiederm at xmission.com
> > > Subject: Re: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and
> device
> > > memory management
> 
> *************************************************************************
> > > This is difficult to achieve without remapping kernel memory using L2
> > > page tables, so we can unmap pages on 4K page granularity.  That's
> > > going to increase TLB overhead and result in lower system performance
> > > as there'll be a greater number of MMU misses.
> *************************************************************************
> 
> > > However, one obvious case would be to use highmem-only pages for
> > > remapping - but you then have to ensure that those pages are never
> > > kmapped in any way, because those mappings will fall into the same
> > > unpredictable category that we're already trying to avoid.  This
> > > may be possible, but you'll have to ensure that most of the system
> > > RAM is in highmem - which poses other problems (eg, if lowmem gets
> > > low.)
> >
> > Why can't we consider an option of removing the old mappings when
> > we need to create new ones with different attributes as suggested
> > by Catalin on similar thread previously. This will avoid the duplicate
> > mapping with different attributes issue on newer ARMs.
> 
> See the first paragraph which I've highlighted above.
>
Sorry about missing that para Russell.
