From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 23 Apr 2010 19:57:40 +0530
Subject: [RFC] Prohibit ioremap() on kernel managed RAM
In-Reply-To: <1272032133.15107.53.camel@e102109-lin.cambridge.arm.com>
References: <20100408094818.GD31407@n2100.arm.linux.org.uk>
	<1272032133.15107.53.camel@e102109-lin.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5092778@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Catalin Marinas
> Sent: Friday, April 23, 2010 7:46 PM
> To: Russell King - ARM Linux
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC] Prohibit ioremap() on kernel managed RAM
> 
> On Thu, 2010-04-08 at 10:48 +0100, Russell King - ARM Linux wrote:
> > ARMv6 and above have a restriction whereby aliasing virtual:physical
> > mappings must not have differing memory type and sharability
> > attributes.  Strictly, this covers the memory type (strongly ordered,
> > device, memory), cache attributes (uncached, write combine, write
> > through, write back read alloc, write back write alloc) and the
> > shared bit.
> >
> > However, using ioremap() and its variants on system RAM results in
> > mappings which differ in these attributes from the main system RAM
> > mapping.  Other architectures which similar restrictions approch this
> > problem in the same way - they do not permit ioremap on main system
> > RAM.
> >
> > Make ARM behave in the same way, with a WARN_ON() such that users can
> > be traced and an alternative approach found.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> BTW, why not do this for /dev/mem mappings with O_SYNC? I think I sent
> you a patch some time ago but I can re-post it.
> 
Above change is necessary but what an alternative approach is for this. 
There are many use case where ioremap* is needed.

Regards,
Santosh
