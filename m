From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Dec 2009 11:09:04 +0000
Subject: [PATCH 3/4] ARM: L2 : Errata 588369: Clean & Invalidate
	donotinvalidate clean lines
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC142138@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BC142138@dbde02.ent.ti.com>
Message-ID: <1260788944.17159.40.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-12-14 at 10:52 +0000, Shilimkar, Santosh wrote:
> > On Wed, 2009-12-09 at 18:43 +0000, Santosh Shilimkar wrote:
> > > +#ifdef CONFIG_PL310_ERRATA_588369
> > > +       /*
> > > +        * Disable Write-Back and Cache Linefill (set bits [1:0] of the Debug
> > > +        * Control Register)
> > > +        */
> > > +       __asm__ __volatile__(
> > > +       "stmfd r13!, {r0-r12, r14}\n"
> > > +       "mov r0, #3\n"
> > > +       "ldr r12, =0x100\n"
> > > +       "dsb\n"
> > > +       "smc\n"
> > > +       "ldmfd r13!, {r0-r12, r14}");
[...]
> > Is a DSB needed before SMC (I'm not sure)?
> 
> That was a recommendation though not having it, I didn't observer any problems.

Maybe it's needed, I'm not sure, but if you found it recommended in some
errata description, then you probably need it.

-- 
Catalin
