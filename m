From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 12:43:56 -0700
Subject: [GIT PULL 4/6] ARM: tegra: device tree changes
In-Reply-To: <1353095038-20031-1-git-send-email-swarren@wwwdotorg.org>
References: <1353095038-20031-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1353095038-20031-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A wide variety of device tree additions are made across many Tegra
boards:

* WiFi is supported on Seaboard, Ventana, and Cardhu.
* An I2C mux is added for Ventana, and Tamonten.
* SPI flash is added to Cardhu, and TrimSlice.
* Temperature sensors are added to Harmony, Tamonten, and Ventana.
* host1x (graphics/display controller) is added to the SoC include files.
* HDMI displays are enabled on Harmony, TrimSlice, Tamonten, Plutux, Tec,
  and Whistler.

This pull request is based on tegra-for-3.8-soc.

----------------------------------------------------------------

The following changes since commit d1d3b978f67c2c000f9d91387cffa630e738d529:

  ARM: tegra: Add Tegra30 host1x clock support

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.8-dt

for you to fetch changes up to 2658ef15b27e0fb166f4b7b997b027a223cd0793:

  ARM: tegra: whistler: enable HDMI port

----------------------------------------------------------------

Laxman Dewangan (3):
      ARM: tegra: dts: add slink controller dt entry
      ARM: tegra: dts: cardhu: enable SLINK4
      ARM: tegra: dts: add sflash controller dt entry

Mark Zhang (1):
      ARM: dt: tegra: ventana: define pinmux for ddc

Stephen Warren (3):
      ARM: tegra: trimslice: enable SPI flash
      ARM: tegra: harmony: enable HDMI port
      ARM: tegra: whistler: enable HDMI port

Thierry Reding (11):
      ARM: tegra: tamonten: Add DDC/PTA pinmux
      ARM: tegra: tec: Remove redundant DT properties
      ARM: tegra: harmony: Add ADT7641 temperature sensor
      ARM: tegra: tamonten: Add NCT1008 temperature sensor
      ARM: tegra: ventana: Add NCT1008 temperature sensor
      ARM: tegra: Add Tegra20 host1x support
      ARM: tegra: Add Tegra30 host1x support
      ARM: tegra: trimslice: enable HDMI port
      ARM: tegra: tamonten: Add host1x support
      ARM: tegra: plutux: Enable HDMI output
      ARM: tegra: tec: Enable HDMI output

Wei Ni (3):
      ARM: dt: t20 seaboard: turn on the power for wlan
      ARM: dt: t20 ventana: set pinmux and power for wlan
      ARM: dt: t30 cardhu: set pinmux and power for wlan

 .../devicetree/bindings/vendor-prefixes.txt     |    1 +
 arch/arm/boot/dts/tegra20-harmony.dts           |   25 ++-
 arch/arm/boot/dts/tegra20-plutux.dts            |    6 +
 arch/arm/boot/dts/tegra20-seaboard.dts          |    6 +
 arch/arm/boot/dts/tegra20-tamonten.dtsi         |   88 ++++++++++-
 arch/arm/boot/dts/tegra20-tec.dts               |    9 +-
 arch/arm/boot/dts/tegra20-trimslice.dts         |   54 ++++++-
 arch/arm/boot/dts/tegra20-ventana.dts           |   90 ++++++++++-
 arch/arm/boot/dts/tegra20-whistler.dts          |   21 ++-
 arch/arm/boot/dts/tegra20.dtsi                  |  137 ++++++++++++++++
 arch/arm/boot/dts/tegra30-cardhu-a02.dts        |    6 +
 arch/arm/boot/dts/tegra30-cardhu-a04.dts        |    6 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |   37 +++++
 arch/arm/boot/dts/tegra30.dtsi                  |  147 ++++++++++++++++++
 14 files changed, 607 insertions(+), 26 deletions(-)
