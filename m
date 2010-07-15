From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 15 Jul 2010 22:13:58 +0530
Subject: [PATCH 1/2] ARM: errata: TLBIASIDIS and TLBIMVAIS operations
	can	broadcast a faulty ASID
In-Reply-To: <002701cb243b$47befb40$d73cf1c0$@deacon@arm.com>
References: <1279209238-16234-1-git-send-email-will.deacon@arm.com>
	<1279209238-16234-2-git-send-email-will.deacon@arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C60875D6@dbde02.ent.ti.com>
	<002701cb243b$47befb40$d73cf1c0$@deacon@arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C60875E2@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Thursday, July 15, 2010 10:02 PM
> To: Shilimkar, Santosh; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH 1/2] ARM: errata: TLBIASIDIS and TLBIMVAIS operations
> can broadcast a faulty ASID
> 
> Hi Santosh,
> 
> > > Subject: [PATCH 1/2] ARM: errata: TLBIASIDIS and TLBIMVAIS operations
> can
> > > broadcast a faulty ASID
> > >
> > > On versions of the Cortex-A9 prior to r2p0, performing TLB
> invalidations
> > > by
> > > ASID match can result in the incorrect ASID being broadcast to other
> CPUs.
> > > As a consequence of this, the targetted TLB entries are not
> invalidated
> > > across the system.
> > >
> > > This workaround changes the TLB flushing routines to invalidate
> entries
> > > regardless of the ASID.
> > >
> > Just a curious question. How costly is this ?
> 
> I think the cost really depends on whether or not the evicted TLB entries
> are available in the D-cache. If they are, then a TLB miss occurring
> because
> of this workaround will hit in the data cache and the overhead will be
> small.
> Missing in the D-cache is certainly going to add an overhead, but that
> depends
> on your memory system.
> 
> Of course, this workaround should only be enabled on platforms that suffer
> from the erratum, where it's worth sacrificing a few cycles in order to
> get
> a working virtual memory system!

Thanks for quick response!!

Regards
Santosh
