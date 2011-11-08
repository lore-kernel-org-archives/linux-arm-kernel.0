From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2011 10:04:08 +0000
Subject: [PATCH 4/5] ARM: restart: s5pv210: use new restart hook XXX
 WIP XXX WHY IS THERE NO LOCAL HEADERS IN arch/arm/mach-exynos4 XXX
In-Reply-To: <04f301cc9dd6$9105cb60$b3116220$%kim@samsung.com>
References: <20111106175457.GK12913@n2100.arm.linux.org.uk>
 <E1RN6xJ-0001aZ-3e@rmk-PC.arm.linux.org.uk>
 <04f301cc9dd6$9105cb60$b3116220$%kim@samsung.com>
Message-ID: <20111108100408.GA12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 02:23:36PM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > 
> > Hook these platforms restart code into the new restart hook rather
> > than using arch_reset().
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

I'm not going to accept that for a patch which will cause a build error.

The purpose of throwing this set of patches out is not to get acks, but
to get people to think about the code that they already have in the
tree which is making the task of others unnecessarily more difficult
because of the way it is structured.

Let me repeat: anything in the list below _will_ be broken by this
patch series:
arch/arm/mach-bcmring/include/mach/system.h
arch/arm/mach-davinci/include/mach/system.h
arch/arm/mach-gemini/include/mach/system.h
arch/arm/mach-ks8695/include/mach/system.h
arch/arm/mach-netx/include/mach/system.h
arch/arm/mach-nomadik/include/mach/system.h
arch/arm/mach-omap1/include/mach/system.h
arch/arm/mach-omap2/include/mach/system.h
arch/arm/mach-s3c2410/include/mach/system-reset.h
arch/arm/mach-s3c64xx/include/mach/system.h
arch/arm/mach-shmobile/include/mach/system.h
arch/arm/mach-vt8500/include/mach/system.h
arch/arm/plat-samsung/include/plat/system-reset.h
arch/arm/plat-tcc/include/mach/system.h

and this includes *all* of the Samsung s3* and s5* stuff.  Exynos4 at
least avoids it because all platforms there use the exynos4_restart()
function.

Also note: it's likely that some platform maintainers *will* want to
base their code off this series.  People submitting new platforms will
want at least part 1 of the series so they can use the new feature.

So we owe it to them (and yourselves) to get the remaining problems
resolved as soon as possible so that the entire series is sound.  So,
don't think there's three months to work on this.
