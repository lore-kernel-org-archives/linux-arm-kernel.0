From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Jul 2012 20:33:35 -0000
Subject: [GIT PULL 11/15] arm-soc: board specific updates
In-Reply-To: <1343075561-17446-1-git-send-email-arnd@arndb.de>
References: <1343075561-17446-1-git-send-email-arnd@arndb.de>
Message-ID: <1343075561-17446-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:

  Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git next/boards

for you to fetch changes up to d003e09891fdc0c170b99328eba7ed004809ef5a:

  Merge branch 'next/board-samsung-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into next/boards (2012-07-21 23:08:03 +0200)

----------------------------------------------------------------

arm-soc: board specific updates

These changes are all for individual board files. In the long run, those
files will largely go away, and the amount of changes appears to be
continuously decreasing, which is a good sign. This time around, changes
are focused on tegra, omap and samsung.

----------------------------------------------------------------

Andy Gross (1):
      omap2+: add drm device

Arnd Bergmann (7):
      Merge branch 'for-3.6/boards' of git://git.kernel.org/.../swarren/linux-tegra into next/boards
      Merge branch 'next/board-samsung' of git://git.kernel.org/.../kgene/linux-samsung into next/boards
      Merge tag 'omap-devel-board-for-v3.6' of git://git.kernel.org/.../tmlind/linux-omap into next/boards
      Merge branch 'next/board-samsung-2' of git://git.kernel.org/.../kgene/linux-samsung into next/boards
      Merge tag 'v3.5-rc7' into next/boards
      Merge branch 'next/board-samsung-3' of git://git.kernel.org/.../kgene/linux-samsung into next/boards
      Merge branch 'next/boards' into for-next

Dimitris Papastamos (1):
      ARM: S3C64XX: Add IRQ mapping for wm0010 on Cragganmore

Dmitry Lifshitz (2):
      ARM: OMAP3: cm-t35: add mt9t001 camera sensor support
      ARM: OMAP3: cm-t35: add tvp5150 decoder support

Kukjin Kim (3):
      Merge branch 'next/board-samsung' into next/board-samsung-2
      Merge branch 'next/board-samsung-2' into next/board-samsung-3
      ARM: SAMSUNG: no need to set the value for clk_xusbxti when it is 24Mhz

Laxman Dewangan (1):
      ARM: tegra: add device tree AUXDATA for APBDMA

Mark Brown (7):
      ARM: S3C64XX: Add module identification for Balblair Cragganmore module
      ARM: S3C64XX: Add WM5102 EVM to Cragganmore modules
      ARM: S3C64XX: Dynamically allocate the IRQ range for WM8994 on Cragganmore
      ARM: S3C64XX: Dynamically assign interrupts for CPU PMIC on Cragganmore
      ARM: S3C64XX: Don't specify an irq_base for WM1192-EV1 board
      ARM: S3C64XX: Clean up after SPI driver platform data updates
      ARM: S3C64XX: Mark most Cragganmore initdata devinitdata

Peter Ujfalusi (2):
      ARM: OMAP: board-4430sdp: MUX configuration for sys_nirq2
      ARM: OMAP: board-omap4panda: MUX configuration for sys_nirq2

Ricardo Salveti de Araujo (1):
      ARM: EXYNOS: Add leds status1 and status2 on Origen board

Sachin Kamat (11):
      ARM: EXYNOS: Add HSOTG support to Origen
      ARM: EXYNOS: Add HSOTG support to SMDKV310
      ARM: EXYNOS: Update keypad entries for SMDK4X12
      ARM: S5PV210: Add HSOTG support to SMDKV210
      ARM: EXYNOS: Add audio platform device in SMDKV310 board
      ARM: S5PV210: Add audio platform device in Aquila board
      ARM: S5PV210: Add audio platform device in Goni board
      ARM: EXYNOS: Add HSOTG support to SMDK4X12
      ARM: EXYNOS: Add framebuffer support for SMDK4X12
      ARM: EXYNOS: Add DRM device to SMDK4X12 board
      ARM: EXYNOS: Add missing .reserve field to SMDKC210

Stephen Warren (7):
      ARM: tegra: make .dts compilation depend on Tegra2 support
      ARM: tegra: remove CONFIG_MACH_TEGRA_DT
      ARM: tegra: remove Seaboard board files
      ARM: tegra: trimslice: enable PCIe when booting from device tree
      ARM: tegra: harmony: init regulators, PCIe when booting from DT
      ARM: tegra: paz00: enable WiFi rfkill when booting from device tree
      ARM: tegra: use of_default_bus_match_table

Tony Lindgren (1):
      ARM: OMAP3: Fix omap3evm randconfig error introduced by VBUS support

Zumeng Chen (4):
      ARM: OMAP3EVM: Add NAND flash definition
      ARM: OMAP3EVM: Adding USB internal LDOs board file
      ARM: omap3evm: enable VBUS switch for EHCI tranceiver
      ARM: OMAP3530evm: set pendown_state and debounce time for ads7846

 arch/arm/Kconfig                                   |    1 +
 arch/arm/mach-exynos/Kconfig                       |    7 +
 arch/arm/mach-exynos/mach-nuri.c                   |    3 +-
 arch/arm/mach-exynos/mach-origen.c                 |   39 ++-
 arch/arm/mach-exynos/mach-smdk4x12.c               |   83 +++++-
 arch/arm/mach-exynos/mach-smdkv310.c               |   17 +-
 arch/arm/mach-exynos/mach-universal_c210.c         |    3 +-
 arch/arm/mach-omap2/Makefile                       |    4 +
 arch/arm/mach-omap2/board-4430sdp.c                |    3 +
 arch/arm/mach-omap2/board-cm-t35.c                 |   89 ++++++
 arch/arm/mach-omap2/board-omap3evm.c               |   78 ++++-
 arch/arm/mach-omap2/board-omap4panda.c             |    3 +
 arch/arm/mach-omap2/common-board-devices.c         |   11 +
 arch/arm/mach-omap2/common-board-devices.h         |    1 +
 arch/arm/mach-omap2/drm.c                          |   61 ++++
 arch/arm/mach-s3c64xx/include/mach/crag6410.h      |    4 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c       |   11 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |   69 +++--
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    1 -
 arch/arm/mach-s5pv210/Kconfig                      |    2 +
 arch/arm/mach-s5pv210/mach-aquila.c                |    7 +
 arch/arm/mach-s5pv210/mach-goni.c                  |   11 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c              |   10 +-
 arch/arm/mach-tegra/Kconfig                        |   36 ---
 arch/arm/mach-tegra/Makefile                       |   13 +-
 arch/arm/mach-tegra/Makefile.boot                  |   10 +-
 arch/arm/mach-tegra/board-dt-tegra20.c             |   74 ++++-
 arch/arm/mach-tegra/board-dt-tegra30.c             |    8 +-
 arch/arm/mach-tegra/board-harmony-pcie.c           |   15 +-
 arch/arm/mach-tegra/board-harmony-power.c          |   25 +-
 arch/arm/mach-tegra/board-paz00.c                  |    7 +-
 arch/arm/mach-tegra/board-seaboard-pinmux.c        |  197 -------------
 arch/arm/mach-tegra/board-seaboard.c               |  306 --------------------
 arch/arm/mach-tegra/board-seaboard.h               |   47 ---
 arch/arm/mach-tegra/board.h                        |    9 +
 drivers/staging/omapdrm/omap_drv.h                 |    2 +-
 .../linux/platform_data/omap_drm.h                 |   19 +-
 37 files changed, 593 insertions(+), 693 deletions(-)
