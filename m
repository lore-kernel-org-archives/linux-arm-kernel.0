From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Sep 2010 12:57:10 +0100
Subject: [PATCH 7/9] ARM: Improve the L2 cache performance when PL310
	is used
In-Reply-To: <20100913113607.GD30787@n2100.arm.linux.org.uk>
References: <20100831135435.21304.38960.stgit@e102109-lin.cambridge.arm.com>
	<20100831135841.21304.55366.stgit@e102109-lin.cambridge.arm.com>
	<20100913113607.GD30787@n2100.arm.linux.org.uk>
Message-ID: <1284379030.875.5.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-09-13 at 12:36 +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 31, 2010 at 02:58:41PM +0100, Catalin Marinas wrote:
> > With this L2 cache controller, the cache maintenance by PA and sync
> > operations are atomic and do not require a "wait" loop. This patch
> > conditionally defines the cache_wait() function.
> > 
> > Since L2x0 cache controllers do not work with ARMv7 CPUs, the patch
> > automatically enables CACHE_PL310 when only CPU_V7 is defined.
> 
> This should be a run-time test, as we're moving towards integrating
> ARMv6 and ARMv7 support into a single kernel image.

Do we expect to get the full ARMv7 performance when compiling a kernel
for both ARMv6 and ARMv7? If not, we can force PL310 to be off in this
configuration.

With the compile-time option we get some macro optimisation but if we
are to detect it we would need a function pointer for calling
cache_wait().

-- 
Catalin
