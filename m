From: khilman@ti.com (Kevin Hilman)
Date: Mon, 29 Aug 2011 11:10:42 -0700
Subject: [PATCH 0/7] OMAP: voltage cleanup part D: voltage domain
Message-ID: <1314641449-5089-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series focuses on cleanup of the remaining voltage domain layer
(non-VC/VP code)

Available in the pm-wip/voltdm_d branch of my linux-omap-pm tree
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Applies on v3.1-rc3 + the part A, B & C series.

Kevin



Kevin Hilman (6):
  OMAP3+: voltage: rename scale and reset functions using voltdm_
    prefix
  OMAP3+: voltage: move/rename curr_volt from vdd_info into struct
    voltagedomain
  OMAP3+: voltdm: final removal of omap_vdd_info
  OMAP3+: voltage: rename omap_voltage_get_nom_volt ->
    voltdm_get_voltage
  OMAP3+: voltage: update nominal voltage in voltdm_scale() not VC
    post-scale
  OMAP2+: VC: more registers are per-channel starting with OMAP5

Tero Kristo (1):
  omap: voltage: add a stub header file for external/regulator use

 arch/arm/mach-omap2/pm.c                      |    2 +-
 arch/arm/mach-omap2/smartreflex-class3.c      |    4 +-
 arch/arm/mach-omap2/vc.c                      |   13 +--
 arch/arm/mach-omap2/vc.h                      |   14 ++--
 arch/arm/mach-omap2/vc3xxx_data.c             |   12 ++-
 arch/arm/mach-omap2/vc44xx_data.c             |   16 +++-
 arch/arm/mach-omap2/voltage.c                 |  107 ++++++++----------------
 arch/arm/mach-omap2/voltage.h                 |   25 ++-----
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |   14 +---
 arch/arm/mach-omap2/voltagedomains44xx_data.c |   15 +---
 arch/arm/plat-omap/include/plat/voltage.h     |   20 +++++
 11 files changed, 104 insertions(+), 138 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/voltage.h

-- 
1.7.6
