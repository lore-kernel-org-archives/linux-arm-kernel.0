From: stigge@antcom.de (Roland Stigge)
Date: Sun, 22 Apr 2012 12:38:40 +0200
Subject: [GIT PULL] LPC32xx: Device tree conversion
Message-ID: <4F93DFB0.4040409@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

this is a rearrangement of all mach-lpc32xx specific patches for device
tree conversion. Please note that:

* It builds upon the i2c-pnx changes (see previous pull request, branch
  lpc32xx/i2c)
* Dave Miller gave permission to merge the lpc_eth.c change via arm-soc
  (patch 1/8)

The rest of the patches is mach-lpc32xx only.

Thanks in advance,

Roland


The following changes since commit b41a216dafe4dd23c95cb4203de288f773a097a6:

  i2c: Add device tree support to i2c-pnx.c (2012-04-22 11:59:47 +0200)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/dt

for you to fetch changes up to 89982a181b0783335d79e6e5264a23009aa7c6e9:

  ARM: LPC32xx: Defconfig update (2012-04-22 12:01:20 +0200)

----------------------------------------------------------------
Roland Stigge (8):
      net: Add device tree support to LPC32xx
      ARM: LPC32xx: clock.c cleanup
      ARM: LPC32xx: clock.c registration adjustment
      ARM: LPC32xx: Remove obsolete platform Kconfig
      ARM: LPC32xx: DTS files for device tree conversion
      ARM: LPC32xx: Device tree support
      ARM: LPC32xx: Move common code to common.c
      ARM: LPC32xx: Defconfig update

 .../devicetree/bindings/arm/lpc32xx-mic.txt        |   38 +++
 Documentation/devicetree/bindings/arm/lpc32xx.txt  |    8 +
 Documentation/devicetree/bindings/net/lpc-eth.txt  |   24 ++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/lpc32xx.dtsi                     |  292 ++++++++++++++++++++
 arch/arm/boot/dts/phy3250.dts                      |  145 ++++++++++
 arch/arm/configs/lpc32xx_defconfig                 |   44 +++-
 arch/arm/mach-lpc32xx/Kconfig                      |   26 --
 arch/arm/mach-lpc32xx/clock.c                      |   77 +++---
 arch/arm/mach-lpc32xx/common.c                     |  205 +-------------
 arch/arm/mach-lpc32xx/common.h                     |   14 -
 arch/arm/mach-lpc32xx/irq.c                        |   78 ++++--
 arch/arm/mach-lpc32xx/phy3250.c                    |  149 ++++-------
 drivers/net/ethernet/nxp/lpc_eth.c                 |   71 ++++--
 14 files changed, 754 insertions(+), 418 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/lpc32xx-mic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/lpc32xx.txt
 create mode 100644 Documentation/devicetree/bindings/net/lpc-eth.txt
 create mode 100644 arch/arm/boot/dts/lpc32xx.dtsi
 create mode 100644 arch/arm/boot/dts/phy3250.dts
