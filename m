From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  5 Apr 2013 11:03:44 -0600
Subject: [GIT PULL 6/8] ARM: tegra: device tree changes
In-Reply-To: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1365181426-11547-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains the majority of the device tree changes for Tegra.
Highlights include:

* Many changes for Tegra114, and the Dalmore board, to enable pinctrl,
  SDHCI/MMC, PWM, DMA, I2C, KBC, SPI, battery, regulators.
* Adding or enabling suspend wakeup sources on many boards, and adding
  suspend timing parameters, to support the system suspend patches.
* Adding clocks to the audio-related nodes, so that in 3.11, the audio
  driver can pull these clocks from device tree rather than hard-coding
  clock names.
* Some small DT fixes/cleanup.

This branch is based on the previous clk pull request.

----------------------------------------------------------------

The following changes since commit 964ea47572b89589b61b553e44bbe9907d4f12a6:

  clk: tegra: fix enum tegra114_clk to match binding

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.10-dt

for you to fetch changes up to 1071b2df22aa45ffeaf34dfccc889d92586ca645:

  clk: tegra: Fix cdev1 and cdev2 IDs

----------------------------------------------------------------

Andrew Chew (2):
      ARM: tegra: fix the status of PWM DT nodes
      ARM: tegra: add PWM nodes to Tegra114 DT

Joseph Lo (4):
      ARM: tegra: add power gpio keys to DT
      ARM: tegra: whistler: add wakeup source for KBC
      ARM: tegra: add non-removable and keep-power-in-suspend property for MMC
      ARM: dts: tegra: add the PM configurations of PMC

Laxman Dewangan (9):
      ARM: tegra: add APB DMA nodes to Tegra114 DT
      ARM: tegra: add I2C nodes to Tegra114 DT
      ARM: tegra: add aliases and DMA requestor for serial nodes of Tegra114
      ARM: tegra: add KBC nodes to Tegra114 DT
      ARM: tegra: add SPI nodes to Tegra114 DT
      ARM: tegra: add DT binding for i2c-tegra
      ARM: tegra: dalmore: add cpu regulator node
      ARM: tegra: dalmore: add TPS65090 node
      ARM: tegra: dalmore: add fixed regulator node

Prashant Gaikwad (1):
      clk: tegra: Fix cdev1 and cdev2 IDs

Pritesh Raithatha (2):
      ARM: tegra: add default pinctrl nodes for Dalmore
      ARM: tegra: add SDHCI nodes with common properties

Rhyland Klein (2):
      ARM: tegra: add SDHCI support for Dalmore
      ARM: tegra: Add sbs-battery node to Dalmore

Stephen Warren (5):
      ARM: tegra: device tree whitespace cleanup
      ARM: tegra: fix sort order of USB PHY nodes
      ARM: tegra: add clocks property to sound nodes
      ARM: tegra: add clocks property to AC'97 sound nodes
      ARM: tegra: keep power on to SD slot on Dalmore

 .../bindings/i2c/nvidia,tegra20-i2c.txt         |   60 ++
 .../sound/nvidia,tegra-audio-alc5632.txt        |    8 +
 .../sound/nvidia,tegra-audio-trimslice.txt      |    7 +
 .../sound/nvidia,tegra-audio-wm8753.txt         |    8 +
 .../sound/nvidia,tegra-audio-wm8903.txt         |    8 +
 .../sound/nvidia,tegra-audio-wm9712.txt         |    8 +
 arch/arm/boot/dts/tegra114-dalmore.dts          |  891 ++++++++++++++++++
 arch/arm/boot/dts/tegra114.dtsi                 |  240 ++++-
 arch/arm/boot/dts/tegra20-colibri-512.dtsi      |   12 +
 arch/arm/boot/dts/tegra20-harmony.dts           |   20 +
 arch/arm/boot/dts/tegra20-medcom-wide.dts       |    7 +
 arch/arm/boot/dts/tegra20-paz00.dts             |   10 +
 arch/arm/boot/dts/tegra20-plutux.dts            |    3 +
 arch/arm/boot/dts/tegra20-seaboard.dts          |   11 +
 arch/arm/boot/dts/tegra20-tamonten.dtsi         |    6 +
 arch/arm/boot/dts/tegra20-tec.dts               |    3 +
 arch/arm/boot/dts/tegra20-trimslice.dts         |   23 +
 arch/arm/boot/dts/tegra20-ventana.dts           |   22 +
 arch/arm/boot/dts/tegra20-whistler.dts          |   13 +
 arch/arm/boot/dts/tegra20.dtsi                  |   53 +-
 arch/arm/boot/dts/tegra30-beaver.dts            |    8 +
 arch/arm/boot/dts/tegra30-cardhu-a02.dts        |    1 +
 arch/arm/boot/dts/tegra30-cardhu-a04.dts        |    1 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |   11 +
 arch/arm/boot/dts/tegra30.dtsi                  |    1 +
 25 files changed, 1405 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
