From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 Nov 2011 17:54:57 +0000
Subject: [03: PATCH 0/5] The remaining stuff
In-Reply-To: <20111106173939.GJ12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <20111106173939.GJ12913@n2100.arm.linux.org.uk>
Message-ID: <20111106175457.GK12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Part 3 - the remaining stuff

These are patches which I've managed to get half way through before
getting - to be honest - totally hacked off with the code found in
various platforms (as mentioned in previous mails).

These platforms are broken as a result of the final patch in part 2,
and these patches move these platforms _towards_ a solution.  They
are not a complete solution though, but the start of the solution.

For instance, the Exynos4 and S5PV210 patches both consist of almost
a full solution -but- with the new function prototype missing because
there is _no_ local header file to put it in, and I'm damned well not
putting it in the remote plat-samsung/include/plat headers.

The final set of platforms - touched neither by part 3 nor 4, are
broken by the final patch in part 2, and at present I have no plans
to fix them.  I would welcome patches to fix these which address the
issues raised in the "pet peaves" email (which is why I have no plans
to fix them.)

 arch/arm/mach-exynos4/cpu.c                       |    6 +-----
 arch/arm/mach-exynos4/mach-armlex4210.c           |    1 +
 arch/arm/mach-exynos4/mach-nuri.c                 |    1 +
 arch/arm/mach-exynos4/mach-origen.c               |    1 +
 arch/arm/mach-exynos4/mach-smdk4x12.c             |    2 ++
 arch/arm/mach-exynos4/mach-smdkv310.c             |    2 ++
 arch/arm/mach-exynos4/mach-universal_c210.c       |    1 +
 arch/arm/mach-omap1/board-voiceblue.c             |    5 ++---
 arch/arm/mach-omap1/include/mach/system.h         |    6 ++++++
 arch/arm/mach-omap1/reset.c                       |    4 +---
 arch/arm/mach-omap2/include/mach/system.h         |    6 ++++++
 arch/arm/mach-omap2/prcm.c                        |    4 +---
 arch/arm/mach-s5pv210/cpu.c                       |    6 +-----
 arch/arm/mach-s5pv210/mach-aquila.c               |    1 +
 arch/arm/mach-s5pv210/mach-goni.c                 |    1 +
 arch/arm/mach-s5pv210/mach-smdkc110.c             |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c             |    1 +
 arch/arm/mach-s5pv210/mach-torbreck.c             |    1 +
 arch/arm/plat-omap/include/plat/system.h          |    2 --
 arch/arm/plat-samsung/include/plat/reset.h        |   16 ----------------
 arch/arm/plat-samsung/include/plat/system-reset.h |   11 -----------
 arch/arm/plat-tcc/include/mach/system.h           |    4 ++--
 arch/arm/plat-tcc/system.c                        |    2 +-
 23 files changed, 34 insertions(+), 51 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/reset.h
