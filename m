From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 10 Nov 2011 10:06:03 +0100
Subject: [PATCH] merge i.MX5 into mach-imx
Message-ID: <1320915966-8063-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following series merges i.MX5 support into mach-imx and makes it
possible to compile i.MX5 together with i.MX3/6. I originally wanted
to wait until the next merge window with this, but I think we can
avoid a lot of merging trouble when we just merge it during this
-rc cycle. What do you think?

Sascha

Sascha Hauer (3):
      ARM i.MX5: remove unnecessary includes from board files
      ARM i.MX: Merge i.MX5 support into mach-imx
      ARM i.MX: Update defconfig

 arch/arm/Makefile                                  |    1 -
 .../configs/{mx5_defconfig => imx_v6_v7_defconfig} |   60 +++--
 arch/arm/configs/mx3_defconfig                     |  144 ------------
 arch/arm/mach-imx/Kconfig                          |  239 +++++++++++++++++++
 arch/arm/mach-imx/Makefile                         |   21 ++
 arch/arm/{mach-mx5 => mach-imx}/clock-mx51-mx53.c  |    2 +-
 arch/arm/{mach-mx5/cpu.c => mach-imx/cpu-imx5.c}   |    0
 arch/arm/{mach-mx5 => mach-imx}/cpu_op-mx51.c      |    0
 arch/arm/{mach-mx5 => mach-imx}/cpu_op-mx51.h      |    0
 .../crm_regs.h => mach-imx/crm-regs-imx5.h}        |    0
 arch/arm/{mach-mx5 => mach-imx}/devices-imx50.h    |    0
 arch/arm/{mach-mx5 => mach-imx}/devices-imx51.h    |    0
 arch/arm/{mach-mx5 => mach-imx}/devices-imx53.h    |    0
 arch/arm/{mach-mx5 => mach-imx}/efika.h            |    0
 arch/arm/{mach-mx5/ehci.c => mach-imx/ehci-imx5.c} |    0
 .../eukrea_mbimx51-baseboard.c                     |    0
 .../eukrea_mbimxsd-baseboard.c                     |    0
 arch/arm/{mach-mx5 => mach-imx}/imx51-dt.c         |    0
 arch/arm/{mach-mx5 => mach-imx}/imx53-dt.c         |    0
 .../board-cpuimx51.c => mach-imx/mach-cpuimx51.c}  |    0
 .../mach-cpuimx51sd.c}                             |    0
 .../board-mx50_rdp.c => mach-imx/mach-mx50_rdp.c}  |    0
 .../board-mx51_3ds.c => mach-imx/mach-mx51_3ds.c}  |    0
 .../mach-mx51_babbage.c}                           |    0
 .../mach-mx51_efikamx.c}                           |    0
 .../mach-mx51_efikasb.c}                           |    0
 .../board-mx53_ard.c => mach-imx/mach-mx53_ard.c}  |    1 -
 .../board-mx53_evk.c => mach-imx/mach-mx53_evk.c}  |    1 -
 .../mach-mx53_loco.c}                              |    1 -
 .../board-mx53_smd.c => mach-imx/mach-mx53_smd.c}  |    1 -
 arch/arm/{mach-mx5/mm.c => mach-imx/mm-imx5.c}     |    0
 arch/arm/{mach-mx5 => mach-imx}/mx51_efika.c       |    0
 arch/arm/{mach-mx5/system.c => mach-imx/pm-imx5.c} |   89 +++++++-
 arch/arm/mach-mx5/Kconfig                          |  244 --------------------
 arch/arm/mach-mx5/Makefile                         |   26 --
 arch/arm/mach-mx5/pm-imx5.c                        |   83 -------
 arch/arm/plat-mxc/Kconfig                          |   15 +-
 37 files changed, 379 insertions(+), 549 deletions(-)
 rename arch/arm/configs/{mx5_defconfig => imx_v6_v7_defconfig} (80%)
 delete mode 100644 arch/arm/configs/mx3_defconfig
 rename arch/arm/{mach-mx5 => mach-imx}/clock-mx51-mx53.c (99%)
 rename arch/arm/{mach-mx5/cpu.c => mach-imx/cpu-imx5.c} (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/cpu_op-mx51.c (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/cpu_op-mx51.h (100%)
 rename arch/arm/{mach-mx5/crm_regs.h => mach-imx/crm-regs-imx5.h} (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/devices-imx50.h (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/devices-imx51.h (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/devices-imx53.h (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/efika.h (100%)
 rename arch/arm/{mach-mx5/ehci.c => mach-imx/ehci-imx5.c} (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/eukrea_mbimx51-baseboard.c (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/eukrea_mbimxsd-baseboard.c (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/imx51-dt.c (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/imx53-dt.c (100%)
 rename arch/arm/{mach-mx5/board-cpuimx51.c => mach-imx/mach-cpuimx51.c} (100%)
 rename arch/arm/{mach-mx5/board-cpuimx51sd.c => mach-imx/mach-cpuimx51sd.c} (100%)
 rename arch/arm/{mach-mx5/board-mx50_rdp.c => mach-imx/mach-mx50_rdp.c} (100%)
 rename arch/arm/{mach-mx5/board-mx51_3ds.c => mach-imx/mach-mx51_3ds.c} (100%)
 rename arch/arm/{mach-mx5/board-mx51_babbage.c => mach-imx/mach-mx51_babbage.c} (100%)
 rename arch/arm/{mach-mx5/board-mx51_efikamx.c => mach-imx/mach-mx51_efikamx.c} (100%)
 rename arch/arm/{mach-mx5/board-mx51_efikasb.c => mach-imx/mach-mx51_efikasb.c} (100%)
 rename arch/arm/{mach-mx5/board-mx53_ard.c => mach-imx/mach-mx53_ard.c} (99%)
 rename arch/arm/{mach-mx5/board-mx53_evk.c => mach-imx/mach-mx53_evk.c} (99%)
 rename arch/arm/{mach-mx5/board-mx53_loco.c => mach-imx/mach-mx53_loco.c} (99%)
 rename arch/arm/{mach-mx5/board-mx53_smd.c => mach-imx/mach-mx53_smd.c} (99%)
 rename arch/arm/{mach-mx5/mm.c => mach-imx/mm-imx5.c} (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/mx51_efika.c (100%)
 rename arch/arm/{mach-mx5/system.c => mach-imx/pm-imx5.c} (58%)
 delete mode 100644 arch/arm/mach-mx5/Kconfig
 delete mode 100644 arch/arm/mach-mx5/Makefile
 delete mode 100644 arch/arm/mach-mx5/pm-imx5.c
