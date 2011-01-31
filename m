From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jan 2011 10:10:24 +0000
Subject: [PATCH v3 0/8] Switch ARM platforms from integrator-flash to physmap
Message-ID: <1296468632-30743-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the integrator-flash driver is mostly a duplicate of physmap,
move all users of this driver to physmap and get rid of the
then unused driver.

Changes since v2:
- Add integrator-flash's init()/exit() methods in order to control
  write access to the various onboard programmable components, as
  per RMK request.
- Rebased against 2.6.38-rc2

Changes since initial revision:
- Rebased against linux-next (20110107). It should apply cleanly
  on top of Linus' tree, except for a small conflict in the last
  patch of the serie.

Marc Zyngier (8):
  MTD: Add integrator-flash feature to physmap
  ARM: Realview: Use physmap driver instead of integrator-flash
  ARM: Versatile: Use physmap driver instead of integrator-flash
  ARM: VExpress: Use physmap driver instead of integrator-flash
  ARM: Integrator/AP: Use physmap driver instead of integrator-flash
  ARM: Integrator/CP: Use physmap driver instead of integrator-flash
  ARM: aaec2000: Use physmap driver instead of integrator-flash
  MTD: Remove integrator-flash

 arch/arm/configs/realview-smp_defconfig  |    2 +-
 arch/arm/configs/realview_defconfig      |    2 +-
 arch/arm/configs/versatile_defconfig     |    2 +-
 arch/arm/mach-aaec2000/core.c            |    7 +-
 arch/arm/mach-integrator/integrator_ap.c |   13 +-
 arch/arm/mach-integrator/integrator_cp.c |   13 +-
 arch/arm/mach-realview/core.c            |   31 +---
 arch/arm/mach-versatile/core.c           |   31 +---
 arch/arm/mach-vexpress/v2m.c             |   22 +--
 drivers/mtd/Kconfig                      |    3 +-
 drivers/mtd/maps/Kconfig                 |    4 -
 drivers/mtd/maps/Makefile                |    1 -
 drivers/mtd/maps/integrator-flash.c      |  319 ------------------------------
 drivers/mtd/maps/physmap.c               |   16 ++-
 include/linux/mtd/physmap.h              |    2 +
 15 files changed, 48 insertions(+), 420 deletions(-)
 delete mode 100644 drivers/mtd/maps/integrator-flash.c
