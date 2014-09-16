From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 16 Sep 2014 18:02:43 +0100
Subject: [GIT PULL] vexpress: updates for 3.18
Message-ID: <1410886963.12376.27.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

The following changes since commit 9e82bf014195d6f0054982c463575cdce24292be:

  Linux 3.17-rc5 (2014-09-14 17:50:12 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawel.moll/linux.git tags/vexpress/updates-for-3.18

for you to fetch changes up to f0a325ccfab9814e3f7ebd9c75d3f6a752cac6c3:

  ARM: vexpress: Remove non-DT code (2014-09-16 17:44:06 +0100)

----------------------------------------------------------------
ARM Versatile Express updates for 3.18

- Add DT properties to CLCD nodes (bindings have been merged in 3.17)
- Remove all code used for non-DT (ATAGs based) platform initialisation
  from arch code and drivers.

----------------------------------------------------------------
Pawel Moll (2):
      ARM: vexpress: Add CLCD Device Tree properties
      ARM: vexpress: Remove non-DT code

 arch/arm/Kconfig                                  |   2 +
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi           |  36 ++-
 arch/arm/boot/dts/vexpress-v2m.dtsi               |  36 ++-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts            |  31 ++
 arch/arm/mach-vexpress/Kconfig                    |   3 -
 arch/arm/mach-vexpress/Makefile                   |   3 +-
 arch/arm/mach-vexpress/core.h                     |   7 -
 arch/arm/mach-vexpress/ct-ca9x4.c                 | 212 ------------
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h    |  47 ---
 arch/arm/mach-vexpress/include/mach/hardware.h    |   1 -
 arch/arm/mach-vexpress/include/mach/irqs.h        |   6 -
 arch/arm/mach-vexpress/include/mach/motherboard.h |  88 -----
 arch/arm/mach-vexpress/platsmp.c                  |  42 ---
 arch/arm/mach-vexpress/v2m.c                      | 374 ----------------------
 arch/arm/plat-versatile/Kconfig                   |   2 +-
 drivers/clk/versatile/Makefile                    |   1 -
 drivers/clk/versatile/clk-vexpress-osc.c          |   7 -
 drivers/clk/versatile/clk-vexpress.c              |  86 -----
 drivers/mfd/vexpress-sysreg.c                     |  71 +---
 drivers/misc/vexpress-syscfg.c                    |  60 +---
 drivers/power/reset/vexpress-poweroff.c           |  17 +-
 include/linux/vexpress.h                          |  19 --
 22 files changed, 134 insertions(+), 1017 deletions(-)
 delete mode 100644 arch/arm/mach-vexpress/ct-ca9x4.c
 delete mode 100644 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/motherboard.h
 delete mode 100644 drivers/clk/versatile/clk-vexpress.c
