From: tony@atomide.com (Tony Lindgren)
Date: Wed, 29 Mar 2017 10:09:48 -0700
Subject: [GIT PULL 1/2] omap soc changes for v4.12
Message-ID: <pull-1490807269-842253>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.12/soc-v2-signed

for you to fetch changes up to f0e6876606a54c28c2e03a223d9d51f30718f24a:

  ARM: OMAP2+: mark omap_init_rng as __init (2017-03-28 14:10:09 -0700)

----------------------------------------------------------------
SoC changes for omaps for v4.12 merge window:

- Drop PM_SUSPEND_STANDBY

- Clean up hwmod code in preparation to eventually dynamically
  allocating hwmod data based on device tree data

- Implement hwmod workaround for dra7 DCAN1 and OTG module to prevent
  clockdomain from entering HW_AUTO

- Configure clockdomain and hwmod for dm81xx SATA

- Mark omap_init_rng as __init

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: OMAP2+: mark omap_init_rng as __init

Geert Uytterhoeven (1):
      ARM: OMAP: PM: Drop useless checks for PM_SUSPEND_STANDBY

Kevin Hilman (1):
      ARM: OMAP2+: dm81xx: Add clkdm and hwmod for SATA

Roger Quadros (3):
      ARM: OMAP2+ hwmod: Allow modules to disable HW_AUTO
      ARM: DRA7: hwmod: Fix DCAN1 stuck in transition
      ARM: DRA7: hwmod_data: Prevent wait_target_disable error for usb_otg_ss

Sekhar Nori (1):
      ARM: OMAP2+: omap_hwmod: provide space for more hwmod flags

Tony Lindgren (5):
      ARM: OMAP2+: Remove mostly unused hwmod linkspace
      ARM: OMAP2+: Use list_for_each_entry for hwmod slave_ports
      ARM: OMAP2+: Remove unused CLOCKACT_TEST_ICLK
      ARM: OMAP2+: Make hwmod clkdm_name const
      Merge branch 'hwmod-cleanup' into omap-for-v4.12/soc

 arch/arm/mach-omap1/pm.c                           |   1 -
 arch/arm/mach-omap2/clockdomains81xx_data.c        |  10 +
 arch/arm/mach-omap2/cm81xx.h                       |   1 +
 arch/arm/mach-omap2/devices.c                      |   2 +-
 arch/arm/mach-omap2/omap_hwmod.c                   | 208 ++-------------------
 arch/arm/mach-omap2/omap_hwmod.h                   |  23 +--
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   4 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   2 -
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   2 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   5 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  34 ++++
 arch/arm/mach-omap2/pm.c                           |   1 -
 13 files changed, 78 insertions(+), 216 deletions(-)
