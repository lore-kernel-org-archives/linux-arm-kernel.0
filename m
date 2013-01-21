From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Mon, 21 Jan 2013 18:44:32 +0530
Subject: [PATCH 0/4] ARM: Manage the pl310 erratas in a dynamic way
Message-ID: <20130121131425.GA29838@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches attempts to manage the pl310 erratas
dynamically rather allowing platforms to choose them during
build time.

A bit of information which triggered the cause for this series is here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138066.html

Other alternate option perhaps may be device tree..

regards/srinidhi


srinidhi kasagar (4):
  ARM: cache-l2x0: Manage the errata at run time
  ARM: make the platforms not to select the l2x0 erratas
  ARM: mach-omap2: apply the errata at run time rather
  ARM: apply the l2x0 Errata 769419 at run time

 arch/arm/include/asm/hardware/cache-l2x0.h |    2 +
 arch/arm/kernel/process.c                  |    9 ++-
 arch/arm/mach-omap2/Kconfig                |    2 -
 arch/arm/mach-omap2/sleep44xx.S            |   25 ++++++++--
 arch/arm/mach-tegra/Kconfig                |    3 -
 arch/arm/mach-ux500/Kconfig                |    1 -
 arch/arm/mach-vexpress/Kconfig             |    1 -
 arch/arm/mm/cache-l2x0.c                   |   77 +++++++++++++++-------------
 8 files changed, 70 insertions(+), 50 deletions(-)

-- 
1.7.2.dirty
