From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 17 Mar 2011 13:03:41 +0000
Subject: [PATCH v4 0/7] Switch ARM platforms from integrator-flash to physmap
Message-ID: <1300367028-3916-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the integrator-flash driver is mostly a duplicate of physmap,
move all users of this driver to physmap and get rid of the
then unused driver.

This patch set has been ok'ed by RMK, but the merge path seems
unclear. David Woodhouse cc-ed on the whole patch set in case he'd
prefer to merge it via his MTD tree.

Changes since v3:
- Dropped patch for aaec2000 platform (removed from tree)
- Rebased against next-20110317

Changes since v2:
- Add integrator-flash's init()/exit() methods in order to control
  write access to the various onboard programmable components, as
  per RMK request.
- Rebased against 2.6.38-rc2

Changes since initial revision:
- Rebased against linux-next (20110107). It should apply cleanly
  on top of Linus' tree, except for a small conflict in the last
  patch of the serie.

Marc Zyngier (7):
  MTD: Add integrator-flash feature to physmap
  ARM: Realview: Use physmap driver instead of integrator-flash
  ARM: Versatile: Use physmap driver instead of integrator-flash
  ARM: VExpress: Use physmap driver instead of integrator-flash
  ARM: Integrator/AP: Use physmap driver instead of integrator-flash
  ARM: Integrator/CP: Use physmap driver instead of integrator-flash
  MTD: Remove integrator-flash

 arch/arm/configs/realview-smp_defconfig  |    2 +-
 arch/arm/configs/realview_defconfig      |    2 +-
 arch/arm/configs/versatile_defconfig     |    2 +-
 arch/arm/mach-integrator/integrator_ap.c |   13 +-
 arch/arm/mach-integrator/integrator_cp.c |   13 +-
 arch/arm/mach-realview/core.c            |   31 +---
 arch/arm/mach-versatile/core.c           |   31 +---
 arch/arm/mach-vexpress/v2m.c             |   22 +--
 drivers/mtd/Kconfig                      |    3 +-
 drivers/mtd/maps/Makefile                |    1 -
 drivers/mtd/maps/integrator-flash.c      |  309 ------------------------------
 drivers/mtd/maps/physmap.c               |   16 ++-
 include/linux/mtd/physmap.h              |    2 +
 13 files changed, 45 insertions(+), 402 deletions(-)
 delete mode 100644 drivers/mtd/maps/integrator-flash.c
