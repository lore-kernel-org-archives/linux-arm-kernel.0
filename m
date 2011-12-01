From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 1 Dec 2011 12:21:44 +0000
Subject: [PATCH v3 5/5] ARM: vexpress: DT-based support for CoreTiles
 Express A5x2 and A9x4
In-Reply-To: <1322678364.3180.34.camel@hornet.cambridge.arm.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-6-git-send-email-pawel.moll@arm.com>
 <20111129164050.GC2829@localhost.localdomain>
 <1322678364.3180.34.camel@hornet.cambridge.arm.com>
Message-ID: <20111201122144.GD2026@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 06:39:24PM +0000, Pawel Moll wrote:
> On Tue, 2011-11-29 at 16:40 +0000, Dave Martin wrote:
> > Note that select PL310_ERRATA_753970 if CACHE_PL310 also needs to be
> > propagated to ARCH_VEXPRESS_CA9X4.  Maybe we should have a common symbol
> > which selects/depends on the common stuff instead of duplicating it for
> > every coretile -- they will tend to get out of sync.
> 
> How about that?
> 
> 8<--------------------------------------------------------------
> menu "Versatile Express platform type"
> 	depends on ARCH_VEXPRESS
> 
> config ARCH_VEXPRESS_CORTEX_A5_A9
> 	bool
> 	select ARM_ERRATA_720789
> 	select ARM_ERRATA_751472
> 	select ARM_GIC
> 	select CPU_V7
> 	select HAVE_L2X0_L2CC
> 	select PL310_ERRATA_753970 if CACHE_PL310
> 	help
> 	  VE platforms based on Cortex-A5 or Cortex-A9 processors.

That will work, but we should make it clear that this option does not
provide board support all by itself, maybe:

"Provides common dependencies for VE platforms based on Cortex-A5 or
Cortex-A9 processors.  In order to build a working kernel, you must also
enable one or more core tile support options."

Cheers
---Dave
