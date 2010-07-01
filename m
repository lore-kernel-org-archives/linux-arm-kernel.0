From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 1 Jul 2010 18:28:32 +0200 (CEST)
Subject: [patch 0/2] ARM: Disable outer cache before kexec call
In-Reply-To: <1278000887.7482.12.camel@e102109-lin.cambridge.arm.com>
References: <20100701160206.539545857@linutronix.de>
	<1278000887.7482.12.camel@e102109-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1007011820000.4507@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

On Thu, 1 Jul 2010, Catalin Marinas wrote:
> 
> On Thu, 2010-07-01 at 17:05 +0100, Thomas Gleixner wrote:
> > The following patch series addresses the problem, that the kexec code
> > does not disable the outer cache before disabling the inner cache and
> > jumping into the new kernel. This results in random crashes of the new
> > kernel.
> 
> We may need other ways to work around this problem. There are platforms
> like OMAP3 (I think) where the L2 cache cannot be disabled as Linux is
> running in non-secure (normal) mode.

But it can disable the inner caches? That's weird.

> Cannot some extra cache flushing work around this problem?

We tried to keep the L2 on and just doing the l2x0_inv_all() call and
it hangs.

Thanks,

	tglx
