From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Apr 2014 17:56:31 +0100
Subject: [PATCH 00/16] Another 16 L2C patches
Message-ID: <20140428165631.GM26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, in response to Matt Porter's complaint about breaking prima2, here's
another 16 patches which changes the way the L2 cache is initialised on
many platforms.  This series moves towards a situation where the generic
code initialises the L2 cache itself, with as little help as possible
from board specific code.

A number of platforms are left alone because they're more complex -
these should still eventually be converted.

At some point in the near future, I will see about sorting out their
ordering wrt the previous patch set.  For the time being, they apply
on top of the existing l2c changes.

 arch/arm/include/asm/mach/arch.h  |  3 +++
 arch/arm/kernel/irq.c             | 12 ++++++++++++
 arch/arm/mach-bcm/bcm_5301x.c     |  9 ++-------
 arch/arm/mach-berlin/berlin.c     | 17 ++++++-----------
 arch/arm/mach-exynos/exynos.c     |  8 ++------
 arch/arm/mach-highbank/highbank.c |  9 +++------
 arch/arm/mach-imx/mach-vf610.c    |  9 ++-------
 arch/arm/mach-mvebu/board-v7.c    |  9 ++++++---
 arch/arm/mach-nomadik/cpu-8815.c  | 13 +++----------
 arch/arm/mach-prima2/Makefile     |  1 -
 arch/arm/mach-prima2/common.c     |  6 ++++++
 arch/arm/mach-prima2/l2x0.c       | 17 -----------------
 arch/arm/mach-rockchip/rockchip.c |  9 ++-------
 arch/arm/mach-socfpga/socfpga.c   |  9 ++-------
 arch/arm/mach-sti/board-dt.c      | 20 +++++---------------
 arch/arm/mach-tegra/tegra.c       | 12 +++---------
 arch/arm/mach-vexpress/v2m.c      |  3 ++-
 arch/arm/mach-zynq/common.c       |  8 +++-----
 18 files changed, 62 insertions(+), 112 deletions(-)


-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
