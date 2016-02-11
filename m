From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 11 Feb 2016 03:42:01 +0200
Subject: [GIT PULL] NXP LPC32xx DT Updates for v4.6 #1
Message-ID: <56BBE6E9.1080509@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

please consider to include NXP LPC32xx DT updates (#1) for v4.6.

The changes add description of clock providers and clock consumers,
define default irq types of SoC controllers and add PHY3250 board
regulators.

I'm adding an official LPC32xx maintainer Roland to Cc, however
he seems to be unresponsive for a quite long time (since 2014).

----------------------------------------------------------------

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://github.com/vzapolskiy/linux.git lpc32xx/dt

for you to fetch changes up to d06670e96267d1f1a771f71f5719c0a2c0092ec1:

  arm: dts: phy3250: add SD fixed regulator (2016-02-11 03:06:36 +0200)

----------------------------------------------------------------

Vladimir Zapolskiy (9):
      dt-bindings: create arm/nxp folder and move LPC32xx SoC description to it
      arm: dts: lpc32xx: add device nodes for external oscillators
      arm: dts: lpc32xx: add clock controller device node
      arm: dts: lpc32xx: add clock properties to device nodes
      arm: dts: lpc32xx: add USB clock controller
      arm: dts: lpc32xx: remove clock frequency property from UART device nodes
      arm: dts: lpc32xx: assign interrupt types
      arm: dts: phy3250: add lcd and backlight fixed regulators
      arm: dts: phy3250: add SD fixed regulator

 .../devicetree/bindings/arm/{ => nxp}/lpc32xx.txt  |   0
 arch/arm/boot/dts/lpc32xx.dtsi                     | 150 ++++++++++++++++-----
 arch/arm/boot/dts/phy3250.dts                      |  32 +++++
 3 files changed, 149 insertions(+), 33 deletions(-)
 rename Documentation/devicetree/bindings/arm/{ => nxp}/lpc32xx.txt (100%)
