From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Jul 2013 00:12:38 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.11
Message-ID: <20130715161236.GC23589@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.11

for you to fetch changes up to 84bb08472520882394fe16d7a3548793302563de:

  ARM: dts: imx51-babbage: Pass a real clock to the codec (2013-07-15 22:28:52 +0800)

----------------------------------------------------------------
The imx fixes for 3.11:

* A few device tree source fixes regarding pinctrl, clock, and pwm
  backlight.
* Fixes imx28 and imx51 audio driver failure caused by sgtl5000 codec
  driver change by supplying the correct clock for codec.
* imx6q emi_sel clock muxing and imx6q-iomuxc-gpr macro fixes

----------------------------------------------------------------
Alexander Shiyan (1):
      ARM: i.MX27: Typo fix

Fabio Estevam (1):
      ARM: dts: imx51-babbage: Pass a real clock to the codec

Laurent Pinchart (1):
      ARM i.MX53: mba53: Fix PWM backlight DT node

Liu Ying (1):
      ARM: i.MX6Q: correct emi_sel clock muxing

Markus Pargmann (1):
      ARM: imx27: Fix documentation for SPLL clock

Philipp Zabel (2):
      ARM i.MX53: Fix UART pad configuration
      ARM i.MX6Q: Fix IOMUXC GPR1 defines for ENET_CLK_SEL and IPU1/2_MUX

Shawn Guo (2):
      ARM: mxs: saif0 is the clock provider to sgtl5000
      ARM: imx: fix vf610 enet module clock selection

 .../devicetree/bindings/clock/imx27-clock.txt      |    1 +
 arch/arm/boot/dts/imx28-apx4devkit.dts             |    2 +-
 arch/arm/boot/dts/imx28-evk.dts                    |    2 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |    2 +-
 arch/arm/boot/dts/imx28.dtsi                       |    1 +
 arch/arm/boot/dts/imx51-babbage.dts                |   13 +++++++-
 arch/arm/boot/dts/imx53-mba53.dts                  |    2 +-
 arch/arm/boot/dts/imx53.dtsi                       |   32 ++++++++++----------
 arch/arm/boot/dts/vf610.dtsi                       |    8 ++---
 arch/arm/mach-imx/clk-imx6q.c                      |    5 +--
 arch/arm/mach-imx/clk-vf610.c                      |    2 ++
 arch/arm/mach-imx/mx27.h                           |    2 +-
 include/dt-bindings/clock/vf610-clock.h            |    4 ++-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   16 +++++-----
 14 files changed, 55 insertions(+), 37 deletions(-)
