From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Tue, 8 May 2012 20:32:40 +0530
Subject: [PATCH 0/4] ARM: OMAP2+: Cleanup series in order to remove ARCH_OMAPx
 dependency
Message-ID: <1336489364-19200-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current implementation, some places we are still using
ARCH_OMAPx config option, making it difficult to add new devices;
for example, while adding am33xx device support I came across multiple
instances where I had to patch the existing code to make it work for
am33xx.

This patch tries to cleanup existing code for some of the
ARCH_OMAP2/3/4 dependency on the code.

NOTE: Patch series has been boot tested on omap3evm and
      build tested for all possible combination of
      OMAP2, 3, 4 configurations.

Vaibhav Hiremath (4):
  ARM: OMAP2+: CLEANUP: All OMAP2PLUS uses omap-device.o target so add
    one entry
  ARM: OMAP2+: CLEANUP: Move omap3 dpll ops to dpll3xxx.c
  ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef around
    __omap2_set_globals
  ARM: OMAP2+: CLEANUP: Add new config option for different DPLL
    features

 arch/arm/mach-omap2/Kconfig             |   42 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.c             |   18 -------------
 arch/arm/mach-omap2/common.c            |    8 +-----
 arch/arm/mach-omap2/common.h            |    5 +++
 arch/arm/mach-omap2/dpll3xxx.c          |   14 ++++++++++
 arch/arm/plat-omap/Makefile             |    4 +--
 arch/arm/plat-omap/include/plat/clock.h |   14 ++++++++--
 7 files changed, 74 insertions(+), 31 deletions(-)
