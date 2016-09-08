From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Sep 2016 21:57:09 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20160908045709.GA21591@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:

  Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 95390e3290e8bf69091116e0d91b9754c0e93a24:

  Merge tag 'sunxi-fixes-for-4.8' of https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux into fixes (2016-09-07 21:25:08 -0700)

----------------------------------------------------------------
ARM: SoC fixes

This is a slightly larger batch of fixes that we've been sitting on a few
-rcs. Most of them are simple oneliners, but there are two sets that are
slightly larger and worth pointing out:

 - A set of patches to OMAP to deal with hwmod for RTC on am33xx (beaglebone
   SoC, among others). It's the only clock that ever has a valid offset of 0,
   so a new flag needed introduction once this problem was discovered.

 - A collection of CCI fixes for performance counters discovered once people
   started using it on X-Gene CPUs.

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: logicpd-torpedo-som: Provide NAND ready pin
      ARM: dts: logicpd-somlv: Fix NAND device nodes

Andreas F??rber (1):
      ARM: dts: imx6sx-sabreauto: Fix misspelled property

Anson Huang (1):
      ARM: imx6: add missing BM_CLPCR_BYPASS_PMIC_READY setting for imx6sx

Arnd Bergmann (2):
      Merge tag 'mvebu-fixes-4.8-2' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'ccn/fixes-for-4.8-v2' of git://git.linaro.org/people/pawel.moll/linux into fixes

Dave Gerlach (4):
      ARM: OMAP4+: hwmod: Add hwmod flag for HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET
      ARM: OMAP2+: AM33XX: Add HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET flag to rtc hwmod
      ARM: OMAP4+: Have _omap4_wait_target_* check for valid clkctrl_offs
      ARM: OMAP4+: CM: Remove redundant checks for clkctrl_offs of zero

Fabio Estevam (1):
      ARM: dts: imx6qdl: Fix SPDIF regression

Gregory CLEMENT (1):
      ARM: dts: kirkwood: Fix PCIe label on OpenRD

Hugo Grostabussiat (1):
      ARM: sun5i: Fix typo in trip point temperature

Johan Hovold (3):
      memory: omap-gpmc: allow probe of child nodes to fail
      ARM: dts: overo: fix gpmc nand cs0 range
      ARM: dts: overo: fix gpmc nand on boards with ethernet

Jon Hunter (1):
      ARM: tegra: Correct polarity for Tegra114 PMIC interrupt

Krzysztof Kozlowski (2):
      ARM: dts: exynos: Properly select eMMC HighSpeed mode on Odroid XU
      MAINTAINERS: Switch to kernel.org account for Krzysztof Kozlowski

Mark Rutland (3):
      bus: arm-ccn: fix PMU interrupt flags
      bus: arm-ccn: fix hrtimer registration
      bus: arm-ccn: make event groups reliable

Masahiro Yamada (1):
      MAINTAINERS: add tree entry for ARM/UniPhier architecture

Olof Johansson (9):
      Merge tag 'mvebu-fixes-4.8-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'gpmc-omap-v4.8-rc1' of https://github.com/rogerq/linux into fixes
      Merge tag 'vexpress-fixes-4.8-rc' of git://git.kernel.org/.../sudeep.holla/linux into fixes
      Merge tag 'omap-for-v4.8/fixes-rc2' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'imx-fixes-4.8' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'samsung-fixes-4.8' of git://git.kernel.org/.../krzk/linux into fixes
      Revert "ARM: tegra: fix erroneous address in dts"
      Merge tag 'imx-fixes-4.8-2' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'sunxi-fixes-for-4.8' of https://git.kernel.org/.../mripard/linux into fixes

Pawel Moll (5):
      bus: arm-ccn: Fix PMU handling of MN
      bus: arm-ccn: Do not attempt to configure XPs for cycle counter
      bus: arm-ccn: Fix XP watchpoint settings bitmask
      bus: arm-ccn: Correct required arguments for XP PMU events
      bus: arm-ccn: Add missing event attribute exclusions for host/guest

Peter Chen (4):
      bus: vexpress-config: add missing of_node_put after calling of_parse_phandle
      firmware: arm_scpi: add missing of_node_put after calling of_parse_phandle
      ARM: imx6: add missing BM_CLPCR_BYP_MMDC_CH0_LPM_HS setting for imx6ul
      ARM: imx6ul: populates platform device at .init_machine

Russell King (1):
      ARM: dts: armada-388-clearfog: number LAN ports properly

Sebastian Reichel (1):
      ARM: OMAP3: hwmod data: Add sysc information for DSI

Simon Baatz (1):
      ARM: kirkwood: ib62x0: fix size of u-boot environment partition

Suzuki K Poulose (1):
      arm-cci: pmu: Fix typo in event name

Teresa Remmet (1):
      ARM: dts: am335x: Update elm phandle binding

Tony Lindgren (2):
      Merge branch 'omap-for-v4.8/soc' into omap-for-v4.8/fixes
      Merge branch 'dts-fixes' into omap-for-v4.8/fixes

Vladimir Zapolskiy (1):
      ARM: dts: imx7d-sdb: fix ti,x-plate-ohms property name

 .mailmap                                           |   1 +
 Documentation/arm/CCN.txt                          |  16 +--
 MAINTAINERS                                        |  16 +--
 arch/arm/boot/dts/am335x-baltos.dtsi               |   2 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi             |   2 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |   2 +-
 arch/arm/boot/dts/armada-388-clearfog.dts          |   8 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |   3 -
 arch/arm/boot/dts/imx6qdl.dtsi                     |   2 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts             |   2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |   2 +-
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |   2 +-
 arch/arm/boot/dts/kirkwood-openrd.dtsi             |   4 +
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  11 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   1 +
 arch/arm/boot/dts/omap3-overo-base.dtsi            |   4 +-
 .../boot/dts/omap3-overo-chestnut43-common.dtsi    |   2 -
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi     |   2 -
 arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi  |   3 -
 arch/arm/boot/dts/sun5i-a13.dtsi                   |   2 +-
 arch/arm/boot/dts/tegra114-dalmore.dts             |   2 +-
 arch/arm/boot/dts/tegra114-roth.dts                |   2 +-
 arch/arm/boot/dts/tegra114-tn7.dts                 |   2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   4 +-
 arch/arm/mach-imx/mach-imx6ul.c                    |   1 +
 arch/arm/mach-imx/pm-imx6.c                        |   4 +-
 arch/arm/mach-omap2/cm33xx.c                       |   6 --
 arch/arm/mach-omap2/cminst44xx.c                   |   6 --
 arch/arm/mach-omap2/omap_hwmod.c                   |   8 ++
 arch/arm/mach-omap2/omap_hwmod.h                   |   4 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   2 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  12 +++
 drivers/bus/arm-cci.c                              |   2 +-
 drivers/bus/arm-ccn.c                              | 112 +++++++++++++++------
 drivers/bus/vexpress-config.c                      |   1 +
 drivers/firmware/arm_scpi.c                        |   5 +-
 drivers/memory/omap-gpmc.c                         |  21 ++--
 37 files changed, 172 insertions(+), 109 deletions(-)
