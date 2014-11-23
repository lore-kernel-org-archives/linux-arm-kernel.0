From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Nov 2014 10:37:04 -0800
Subject: [GIT PULL] ARM: SoC fixes for -rc6
Message-ID: <20141123183704.GA10523@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9:

  Linux 3.18-rc5 (2014-11-16 16:36:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-for-rc6

for you to fetch changes up to 49e41938f8a53d01d1c5d133a038acb9650008f9:

  ARM: multi_v7_defconfig: fix failure setting CPU voltage by enabling dependent I2C controller (2014-11-19 09:35:17 -0800)

----------------------------------------------------------------
ARM: SoC fixes for 3.18-rc6

A collection of fixes this week:

- A set of clock fixes for shmobile platforms
- A fix for tegra that moves serial port labels to be per board.
  We're choosing to merge this for 3.18 because the labels will start
  being parsed in 3.19, and without this change serial port numbers that
  used to be stable since the dawn of time will change numbers.
- A few other DT tweaks for Tegra.
- A fix for multi_v7_defconfig that makes it stop spewing cpufreq errors on
  Arndale (Exynos).

----------------------------------------------------------------
Alexandre Courbot (2):
      ARM: tegra: Remove eMMC vmmc property for roth/tn7
      ARM: tegra: roth: Fix SD card VDD_IO regulator

Arnd Bergmann (5):
      Merge tag 'sunxi-fixes-for-3.18' of git://git.kernel.org/.../mripard/linux into fixes
      Merge tag 'renesas-soc-fixes-for-v3.18' of git://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'renesas-dt-fixes-for-v3.18' of git://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'renesas-clock-fixes-for-v3.18' of git://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'tegra-for-3.18-fixes-for-rc5' of git://git.kernel.org/.../tegra/linux into fixes

Chen-Yu Tsai (1):
      ARM: dts: sun6i: Re-parent ahb1_mux to pll6 as required by dma controller

Geert Uytterhoeven (4):
      ARM: shmobile: r8a7740 legacy: Add missing INTCA clock for irqpin module
      ARM: shmobile: r8a7740 legacy: Correct IIC0 parent clock
      ARM: shmobile: r8a7740 dtsi: Correct IIC0 parent clock
      ARM: shmobile: kzm9g legacy: Set i2c clks_per_count to 2

Lucas Stach (1):
      ARM: tegra: Add serial port labels to Tegra124 DT

Olof Johansson (1):
      ARM: dts: tegra: move serial aliases to per-board

Shinobu Uehara (2):
      ARM: shmobile: r8a7790: Fix SD3CKCR address
      ARM: shmobile: r8a7790: Fix SD3CKCR address to device tree

Tyler Baker (1):
      ARM: multi_v7_defconfig: fix failure setting CPU voltage by enabling dependent I2C controller

 arch/arm/boot/dts/r8a7740.dtsi                |  2 +-
 arch/arm/boot/dts/r8a7790.dtsi                |  4 ++--
 arch/arm/boot/dts/sun6i-a31.dtsi              |  4 ++++
 arch/arm/boot/dts/tegra114-dalmore.dts        |  1 +
 arch/arm/boot/dts/tegra114-roth.dts           |  9 +++++----
 arch/arm/boot/dts/tegra114-tn7.dts            |  5 ++++-
 arch/arm/boot/dts/tegra114.dtsi               |  7 -------
 arch/arm/boot/dts/tegra124-jetson-tk1.dts     |  1 +
 arch/arm/boot/dts/tegra124-nyan-big.dts       |  1 +
 arch/arm/boot/dts/tegra124-venice2.dts        |  1 +
 arch/arm/boot/dts/tegra124.dtsi               |  8 ++++----
 arch/arm/boot/dts/tegra20-harmony.dts         |  1 +
 arch/arm/boot/dts/tegra20-iris-512.dts        |  5 +++++
 arch/arm/boot/dts/tegra20-medcom-wide.dts     |  4 ++++
 arch/arm/boot/dts/tegra20-paz00.dts           |  2 ++
 arch/arm/boot/dts/tegra20-seaboard.dts        |  1 +
 arch/arm/boot/dts/tegra20-tamonten.dtsi       |  1 +
 arch/arm/boot/dts/tegra20-trimslice.dts       |  1 +
 arch/arm/boot/dts/tegra20-ventana.dts         |  1 +
 arch/arm/boot/dts/tegra20-whistler.dts        |  1 +
 arch/arm/boot/dts/tegra20.dtsi                |  8 --------
 arch/arm/boot/dts/tegra30-apalis-eval.dts     |  4 ++++
 arch/arm/boot/dts/tegra30-beaver.dts          |  1 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi         |  2 ++
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  3 +++
 arch/arm/boot/dts/tegra30.dtsi                |  8 --------
 arch/arm/configs/multi_v7_defconfig           |  1 +
 arch/arm/mach-shmobile/clock-r8a7740.c        |  9 +++++++--
 arch/arm/mach-shmobile/clock-r8a7790.c        |  2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c         | 20 ++++++++++++++++++++
 30 files changed, 80 insertions(+), 38 deletions(-)
