From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 May 2010 15:49:35 +0100
Subject: [PATCH 0/4] Patches for -next
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C56FF34E@dbde02.ent.ti.com>
References: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5667016@dbde02.ent.ti.com>
	<1274435541.11965.18.camel@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C56FF34E@dbde02.ent.ti.com>
Message-ID: <1274453375.7246.49.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-05-21 at 11:57 +0100, Shilimkar, Santosh wrote:
> Catalin,
> 
> > -----Original Message-----
> > From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> > Sent: Friday, May 21, 2010 3:22 PM
> > To: Shilimkar, Santosh
> > Cc: Russell King - ARM Linux; linux-arm-kernel at lists.infradead.org
> > Subject: RE: [PATCH 0/4] Patches for -next
> >
> > Santosh,
> >
> > On Fri, 2010-05-21 at 06:59 +0100, Shilimkar, Santosh wrote:
> > > > Catalin Marinas (4):
> > > >       ARM: Remove the domain switching on ARMv6k/v7 CPUs
> > > >       ARM: Use lazy cache flushing on ARMv7 SMP systems
> > > >       ARM: Assume new page cache pages have dirty D-cache
> > > >       ARM: Defer the L_PTE_EXEC flag setting to update_mmu_cache() on SMP
> > > >
> > > >
> > > I just gave quick try with these patches on OMAP4 yesterday.
> > > "ARM: Defer the L_PTE_EXEC flag setting to update_mmu_cache() on SMP"
> > > patch is creating regression when loading the module.
> >
> > Thanks for testing and reporting this. I missed the fact the modules
> > allocation uses set_pte_at(). Below is an updated patch which makes sure
> > that L_PTE_EXEC is set for addresses greater than TASK_SIZE. We
> > shouldn't have a race for modules as initialisation only happens on a
> > single CPU.
> >
> > Could you please try the updated patch below?
> >
> This one works fine!!
> You can add, Tested-by: Santosh Shilimkar <Santosh.shilimkar@ti.com>

Thanks for testing.

Have you tried the whole series or just this one?

-- 
Catalin
