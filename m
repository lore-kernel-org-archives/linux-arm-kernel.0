From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Mar 2010 14:10:12 +0000
Subject: [PATCH v4 0/4] ARM mandatory barriers
In-Reply-To: <20100319134614.14625.18408.stgit@e102109-lin.cambridge.arm.com>
References: <20100319134614.14625.18408.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <1269007812.31227.7.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-03-19 at 13:48 +0000, Catalin Marinas wrote:
> Updated series on the ARM mandatory barriers. As per Russell's
> suggestion, most platform seem to define the mb() as dsb(); outer_sync()
> and it makes sense to make this the default (if CONFIG_OUTER_CACHE_SYNC
> is defined). The patch still allows per-platform barriers via the
> CONFIG_ARCH_HAS_BARRIERS option.
> 
> 
> Catalin Marinas (4):
>       ARM: Move the outer_cache definitions into a separate file
>       ARM: Add outer_cache_fns.sync function pointer
>       ARM: Add L2x0 outer_sync() support
>       ARM: Change the mandatory barriers implementation

I based the series on some of my other patches, so just applying these
patches on top of mainline wouldn't even compile. I'll repost cleaner
patches shortly (v5).

-- 
Catalin
