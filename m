From: colin.tuckley@arm.com (Colin Tuckley)
Date: Tue, 9 Mar 2010 10:30:01 -0000
Subject: [PATCH] ARM: Improve the L2 cache performance when PL310 is used
In-Reply-To: <20100309101248.7359.60873.stgit@e102109-lin.cambridge.arm.com>
References: <20100309101248.7359.60873.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <000401cabf73$79a19fa0$6ce4dee0$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Catalin Marinas


> With this L2 cache controller, the cache maintenance by PA and sync
> operations are atomic and do not require a "wait" loop or spinlocks.
> This patch conditionally defines the cache_wait() function and locking
> primitives (rather than duplicating the functions or file).
> 
> Since L2x0 cache controllers do not work with ARMv7 CPUs, the patch
> automatically enables CACHE_PL310 when CPU_V7 is defined.

That will cause a problem with A8 CPUs which are V7 but which do *not* use a
PL310 for the L2 cache.

Colin
