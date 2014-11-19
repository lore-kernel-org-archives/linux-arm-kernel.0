From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Nov 2014 15:07:53 +0800
Subject: [GIT PULL] ARM: imx: device tree changes for 3.19
Message-ID: <20141119070752.GG27759@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

This pull request is based on the SoC pull request which tagged as
imx-soc-3.19.  Please pull, thanks.

Shawn

The following changes since commit dc7aaa041842eb40be7ad7bde0a7e37ac1efd79c:

  ARM: configs: imx_v6_v7_defconfig: add power off driver (2014-11-19 11:51:55 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-3.19

for you to fetch changes up to c95e259674da685152eb093263478c7ada0aa904:

  ARM: dts: imx6: add pm_power_off support for i.mx6 chips (2014-11-19 11:59:38 +0800)

----------------------------------------------------------------
The i.MX device tree changes for 3.19:
 - Device additions for board vf610-colibri, pwm, backlight, I2C, RTC,
   ADC etc.
 - Update i.MX6 phyFLEX board to include PCIe, CAN and audio support
 - Improve SSI clocks description for i.MX5 platforms
 - Add ENET2 support for imx6sx-sdb board
 - Add device tree source for LS1021A SoC, board QDS and TWR
 - Enable cpufreq support for i.MX53
 - Enable VPU device support for i.MX6QDL
 - Enable poweroff support for i.MX6 SoCs
 - Add support for TBS2910 Matrix ARM mini PC which is built on i.MX6Q
 - Create generic base device trees for Vybrid and add support for
   Colibri VF50

----------------------------------------------------------------
Bhuvanchandra DV (5):
      ARM: dts: vf610: Add PWM second instance
      ARM: dts: vf610-colibri: Add PWM support
      ARM: dts: vf610-colibri: Add backlight support
      ARM: dts: vf-colibri: Add I2C support
      ARM: dts: vf-colibri-eval-v3.dts: Enable ST-M41T0M6 RTC

Christian Hemp (5):
      ARM: dts: imx6: phyFLEX: set nodes in alphabetical order
      ARM: dts: imx6: phyFLEX: Enable gpmi in module file
      ARM: dts: imx6: phyFLEX: Set correct interrupt for pmic
      ARM: dts: imx6: phyFLEX: Add PCIe
      ARM: dts: imx6: phyFLEX: Add CAN support

Dmitry Lavnikevich (2):
      ARM: dts: pbab01: move i2c pins and frequency configuration into pfla02
      ARM: dts: pbab01: enable I2S audio on phyFLEX-i.MX6 boards

Fabio Estevam (3):
      ARM: dts: imx53: Improve SSI clocks description
      ARM: dts: imx51: Improve SSI clocks description
      ARM: dts: imx6q-tbs2910: Remove unneeded 'fsl,mode' property

Fugang Duan (1):
      ARM: dts: imx6x: Add enet2 support for imx6sx-sdb board

Jingchang Lu (4):
      ARM: dts: Add SoC level device tree support for LS1021A
      ARM: dts: Add initial LS1021A QDS board dts support
      ARM: dts: Add initial LS1021A TWR board dts support
      dt-bindings: arm: add Freescale LS1021A SoC device tree binding

Lucas Stach (1):
      ARM: dts: imx53: add cpufreq-dt support

Philipp Zabel (1):
      ARM: dts: imx6qdl: Enable CODA960 VPU

Robin Gong (1):
      ARM: dts: imx6: add pm_power_off support for i.mx6 chips

Sanchayan Maity (1):
      ARM: dts: vf610-colibri: Add ADC support

Soeren Moch (2):
      devicetree: bindings: Add vendor prefix for TBS Technologies
      ARM: dts: add initial support for TBS2910 Matrix ARM mini PC

Stefan Agner (7):
      ARM: dts: vf610: Add ARM Global Timer
      ARM: dts: vf610: assign oscillator to clock module
      ARM: dts: vf610: create generic base device trees
      ARM: dts: vf500-colibri: add Colibri VF50 support
      ARM: dts: vf610: use new GPIO support
      ARM: dts: vf610: enable USB misc/phy nodes where necessary
      ARM: dts: vf-colibri: add USB regulators

Vladimir Zapolskiy (1):
      ARM: dts: imx6dl: add alias for I2C4 bus

 Documentation/devicetree/bindings/arm/fsl.txt      |  38 ++
 .../devicetree/bindings/clock/vf610-clock.txt      |  15 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/imx51.dtsi                       |  12 +-
 arch/arm/boot/dts/imx53.dtsi                       |  25 +-
 arch/arm/boot/dts/imx6dl.dtsi                      |   8 +
 arch/arm/boot/dts/imx6q-tbs2910.dts                | 428 ++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi                       |   4 +
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi       | 131 ++++--
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |  97 +++-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   4 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |  14 +
 arch/arm/boot/dts/imx6sl-evk.dts                   |   4 +
 arch/arm/boot/dts/imx6sl.dtsi                      |   6 +
 arch/arm/boot/dts/imx6sx-sdb.dts                   |  66 +++
 arch/arm/boot/dts/imx6sx.dtsi                      |   8 +-
 arch/arm/boot/dts/ls1021a-qds.dts                  | 240 ++++++++++
 arch/arm/boot/dts/ls1021a-twr.dts                  | 127 ++++++
 arch/arm/boot/dts/ls1021a.dtsi                     | 408 +++++++++++++++++
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |  96 ++++
 arch/arm/boot/dts/vf-colibri.dtsi                  | 186 ++++++++
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts        |  17 +
 arch/arm/boot/dts/vf500-colibri.dtsi               |  20 +
 arch/arm/boot/dts/vf500.dtsi                       | 171 ++++++++
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts        |  33 +-
 arch/arm/boot/dts/vf610-colibri.dtsi               | 100 +----
 arch/arm/boot/dts/vf610-cosmic.dts                 |  14 +-
 arch/arm/boot/dts/vf610-twr.dts                    |  46 +-
 arch/arm/boot/dts/vf610.dtsi                       | 486 +--------------------
 arch/arm/boot/dts/vfxxx.dtsi                       | 437 ++++++++++++++++++
 31 files changed, 2575 insertions(+), 671 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-tbs2910.dts
 create mode 100644 arch/arm/boot/dts/ls1021a-qds.dts
 create mode 100644 arch/arm/boot/dts/ls1021a-twr.dts
 create mode 100644 arch/arm/boot/dts/ls1021a.dtsi
 create mode 100644 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
 create mode 100644 arch/arm/boot/dts/vf-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/vf500-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/vf500-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/vf500.dtsi
 create mode 100644 arch/arm/boot/dts/vfxxx.dtsi
