From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 09 Mar 2010 10:52:39 +0000
Subject: [PATCH] ARM: Improve the L2 cache performance when PL310 is used
In-Reply-To: <000401cabf73$79a19fa0$6ce4dee0$@tuckley@arm.com>
References: <20100309101248.7359.60873.stgit@e102109-lin.cambridge.arm.com>
	<000401cabf73$79a19fa0$6ce4dee0$@tuckley@arm.com>
Message-ID: <1268131959.3239.11.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-09 at 10:30 +0000, Colin Tuckley wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Catalin Marinas
> 
> 
> > With this L2 cache controller, the cache maintenance by PA and sync
> > operations are atomic and do not require a "wait" loop or spinlocks.
> > This patch conditionally defines the cache_wait() function and locking
> > primitives (rather than duplicating the functions or file).
> > 
> > Since L2x0 cache controllers do not work with ARMv7 CPUs, the patch
> > automatically enables CACHE_PL310 when CPU_V7 is defined.
> 
> That will cause a problem with A8 CPUs which are V7 but which do *not* use a
> PL310 for the L2 cache.

But do they use an L220? Or they don't use anything?

Note that CACHE_PL310 depends on CACHE_L2X0, so if you don't have an
outer cache controller, you don't get CACHE_PL310 enabled.

-- 
Catalin
