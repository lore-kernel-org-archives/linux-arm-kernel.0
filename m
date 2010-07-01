From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 1 Jul 2010 22:08:37 +0530
Subject: [patch 0/2] ARM: Disable outer cache before kexec call
In-Reply-To: <alpine.LFD.2.00.1007011820000.4507@localhost.localdomain>
References: <20100701160206.539545857@linutronix.de>
	<1278000887.7482.12.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007011820000.4507@localhost.localdomain>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5E41E0C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Thomas Gleixner
> Sent: Thursday, July 01, 2010 9:59 PM
> To: Catalin Marinas
> Cc: LAK
> Subject: Re: [patch 0/2] ARM: Disable outer cache before kexec call
> 
> Catalin,
> 
> On Thu, 1 Jul 2010, Catalin Marinas wrote:
> >
> > On Thu, 2010-07-01 at 17:05 +0100, Thomas Gleixner wrote:
> > > The following patch series addresses the problem, that the kexec code
> > > does not disable the outer cache before disabling the inner cache and
> > > jumping into the new kernel. This results in random crashes of the new
> > > kernel.
> >
> > We may need other ways to work around this problem. There are platforms
> > like OMAP3 (I think) where the L2 cache cannot be disabled as Linux is
> > running in non-secure (normal) mode.
> 
> But it can disable the inner caches? That's weird.
> 
If the C bit is disabled then it is as good as L1 and L2 are disabled.

> > Cannot some extra cache flushing work around this problem?
> 
> We tried to keep the L2 on and just doing the l2x0_inv_all() call and
> it hangs.
>

Regards,
Santosh
