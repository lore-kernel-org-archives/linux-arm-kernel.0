From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 15:10:11 -0700
Subject: [GIT PULL 09/10] ARM: tegra: device tree changes
In-Reply-To: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
References: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1387231812-5701-9-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains all the changes to Tegra's device tree. The
highlights are:

* Many patches for Tegra124 SoC support, and the Venice2 board which
  uses that SoC.
* Conversion to use more headers providing named constants for pinctrl
  and key codes, which improves readability.
* A few cleanups.

This branch is based on tag tegra-for-3.14-dmas-resets-rework in order
to avoid conflicts with the DT changes required to use the common
bindings for DMAs and resets.

----------------------------------------------------------------

The following changes since commit 8a0a1af30cbf56b41220a02e34835022c4d72f41:

  spi: tegra: checking for ERR_PTR instead of NULL

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.14-dt

for you to fetch changes up to 9f1ac5606a008f4849208ebfe818f979619dced0:

  ARM: tegra: Add SPI controller nodes for Tegra124

----------------------------------------------------------------

Ashwini Ghuge (1):
      ARM: tegra: add port FF to GPIO IDs

Joseph Lo (1):
      ARM: tegra: add clock properties for devices of Tegra124

Laxman Dewangan (6):
      ARM: tegra: convert device tree files to use key defines
      ARM: tegra: Add header file for pinctrl constants
      ARM: tegra: convert dts files of Tegra114 platforms to use pinctrl defines
      ARM: tegra: convert dts files of Tegra20 platforms to use pinctrl defines
      ARM: tegra: convert dts files of Tegra30 platforms to use pinctrl defines
      ARM: tegra: add default pinctrl nodes for Venice2

Stefan Agner (1):
      ARM: tegra: correct Colibri T20 regulator settings

Stephen Warren (11):
      ARM: tegra: add missing unit addresses to DT
      ARM: tegra: fix node sort order
      ARM: tegra: add reset properties to Tegra124 DTs
      ARM: tegra: add APB DMA controller to Tegra124 DT
      ARM: tegra: add Tegra124 pinmux node to DT
      ARM: tegra: add MMC controllers to Tegra124 DT
      ARM: tegra: add I2C controllers to Tegra124 DT
      ARM: tegra: enable I2C controllers on Venice2
      ARM: tegra: add audio-related device to Tegra124 DT
      ARM: tegra: add sound card to Venice2 DT
      ARM: tegra: fix pinctrl misconfiguration on Venice2

Thierry Reding (4):
      ARM: tegra: Add Tegra124 PWM support
      ARM: tegra: Enable PWM on Venice2
      ARM: tegra: Fix misconfiguration of pin PH2 on Venice2
      ARM: tegra: Add SPI controller nodes for Tegra124

 arch/arm/boot/dts/tegra114-dalmore.dts      | 566 +++++++++++------------
 arch/arm/boot/dts/tegra114.dtsi             |  25 +-
 arch/arm/boot/dts/tegra124-venice2.dts      | 433 +++++++++++++++++
 arch/arm/boot/dts/tegra124.dtsi             | 418 +++++++++++++++++
 arch/arm/boot/dts/tegra20-colibri-512.dtsi  | 200 ++++----
 arch/arm/boot/dts/tegra20-harmony.dts       | 279 +++++------
 arch/arm/boot/dts/tegra20-iris-512.dts      |  30 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts   |   2 +-
 arch/arm/boot/dts/tegra20-paz00.dts         |  45 +-
 arch/arm/boot/dts/tegra20-plutux.dts        |   4 +-
 arch/arm/boot/dts/tegra20-seaboard.dts      | 348 +++++++-------
 arch/arm/boot/dts/tegra20-tamonten.dtsi     |  42 +-
 arch/arm/boot/dts/tegra20-tec.dts           |   6 +-
 arch/arm/boot/dts/tegra20-trimslice.dts     |  49 +-
 arch/arm/boot/dts/tegra20-ventana.dts       |  57 +--
 arch/arm/boot/dts/tegra20-whistler.dts      |  79 ++--
 arch/arm/boot/dts/tegra20.dtsi              |  55 +--
 arch/arm/boot/dts/tegra30-beaver.dts        | 112 ++---
 arch/arm/boot/dts/tegra30-cardhu-a02.dts    |  14 +-
 arch/arm/boot/dts/tegra30-cardhu-a04.dts    |  14 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi       |  62 +--
 arch/arm/boot/dts/tegra30.dtsi              |  51 +-
 include/dt-bindings/gpio/tegra-gpio.h       |   1 +
 include/dt-bindings/pinctrl/pinctrl-tegra.h |  45 ++
 24 files changed, 1922 insertions(+), 1015 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra.h
