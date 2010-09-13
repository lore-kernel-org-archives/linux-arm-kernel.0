From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Sep 2010 12:36:07 +0100
Subject: [PATCH 7/9] ARM: Improve the L2 cache performance when PL310
	is used
In-Reply-To: <20100831135841.21304.55366.stgit@e102109-lin.cambridge.arm.com>
References: <20100831135435.21304.38960.stgit@e102109-lin.cambridge.arm.com>
	<20100831135841.21304.55366.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100913113607.GD30787@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 02:58:41PM +0100, Catalin Marinas wrote:
> With this L2 cache controller, the cache maintenance by PA and sync
> operations are atomic and do not require a "wait" loop. This patch
> conditionally defines the cache_wait() function.
> 
> Since L2x0 cache controllers do not work with ARMv7 CPUs, the patch
> automatically enables CACHE_PL310 when only CPU_V7 is defined.

This should be a run-time test, as we're moving towards integrating
ARMv6 and ARMv7 support into a single kernel image.
