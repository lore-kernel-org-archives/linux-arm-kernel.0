From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 09 May 2015 22:39:40 +0200
Subject: [GIT PULL] arm-soc fixes for 4.1-rc2
Message-ID: <2405006.PalEckFCK2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to c9d862c48c48883a4327ae82f4a6de1eef928d60:

  MAINTAINERS: add Conexant Digicolor machines entry (2015-05-08 19:00:53 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.1-rc2

A few patches have come up since the merge window. The largest one is a
rewrite of the PXA lubbock/mainstone IRQ handling. This was already
broken in 2011 by a change to the GPIO code and only noticed now.

The other changes contained here are:

MAINTAINERS file updates:
- Ray Jui and Scott Branden are now co-maintainers for some of the
  mach-bcm chips, while Christian Daudt and Marc Carino have stepped
  down.
- Andrew Victor is no longer maintaining at91. Instead, Alexandre
  Belloni now becomes an official maintainer, after having done a
  bulk of the work for a while.
- Baruch Siach, who added the mach-digicolor platform in 4.1
  is now listed as maintainer
- The git URL for mach-socfpga has changed

Bug fixes:
- Three bug fixes for new rockchip rk3288 code
- A regression fix to make SD card support work on certain ux500
  boards
- multiple smaller dts fixes for imx, omap, mvebu, and shmobile
- a regression ?ix for omap3 power consumption
- a fix for regression in the ARM CCI bus driver

Configuration changes:
- more imx platforms are now enabled in multi_v7_defconfig

----------------------------------------------------------------
Arnd Bergmann (8):
      Merge tag 'v4.1-rockchip-socfixes1' of git://git.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'imx-fixes-4.1' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'fixes-for-v4.1-rc2' of https://github.com/rjarzmik/linux into fixes
      Merge tag 'mvebu-fixes-4.1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'arm-soc/for-4.1/maintainers' of http://github.com/broadcom/stblinux into fixes
      Merge tag 'omap-for-v4.1/fixes-rc1' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'renesas-fixes-for-v4.1' of git://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'stericsson-fixes-v4.1' of git://git.kernel.org/.../linusw/linux-stericsson into fixes

Baruch Siach (1):
      MAINTAINERS: add Conexant Digicolor machines entry

Chris Zhong (2):
      ARM: rockchip: disable dapswjdp during suspend
      ARM: rockchip: fix undefined instruction of reset_ctrl_regs

Dinh Nguyen (1):
      MAINTAINERS: socfpga: update the git repo for SoCFPGA

Fabio Estevam (2):
      ARM: dts: imx23-olinuxino: Fix polarity of LED GPIO
      ARM: multi_v7_defconfig: Select more FSL SoCs

Felipe Balbi (2):
      ARM: dts: am437x-sk: fix for new newhaven display module revision
      ARM: dts: am437x-sk: reduce col-scan-delay-us

Florian Fainelli (3):
      MAINTAINERS: Update mach-bcm maintainers list
      MAINTAINERS: Remove Christian Daudt for mach-bcm
      MAINTAINERS: Update brcmstb entry

Gregory CLEMENT (1):
      ARM: mvebu: armada-xp-openblocks-ax3-4: Disable internal RTC

Grygorii Strashko (1):
      ARM: dts: am57xx-beagle-x15: Fix IRQ type for mcp7941x

Heiko Stuebner (1):
      rockchip: make sure timer7 is enabled on rk3288 platforms

Illia Smyrnov (1):
      bus: omap_l3_noc: Fix offset for DRA7 CLK1_HOST_CLK1_2 instance

Laurent Pinchart (1):
      ARM: shmobile: koelsch: Fix adv7511 IRQ sensing

Marek Vasut (1):
      ARM: dts: imx28: Fix AUART4 TX-DMA interrupt name

Mark Salter (1):
      drivers: CCI: fix used_mask init in validate_group()

Markus Pargmann (1):
      ARM: dts: imx25: Add #pwm-cells to pwm4

Nicolas Ferre (1):
      MAINTAINERS: replace an AT91 maintainer

Nishanth Menon (4):
      ARM: dts: am57xx-beagle-x15: Fix RTC aliases
      ARM: dts: am57xx-beagle-x15: Switch UART mux pins
      ARM: dts: am57xx-beagle-x15: Switch GPIO fan number
      ARM: dts: dra7: Fix efuse register size for ABB

Pavel Machek (1):
      ARM: dts: OMAP3-N900: Add microphone bias voltages

Philipp Zabel (1):
      ARM: dts: imx6: phyFLEX: USB VBUS control is active-high

Robert Jarzmik (3):
      ARM: pxa: pxa_cplds: add lubbock and mainstone IO
      ARM: pxa: mainstone: use new pxa_cplds driver
      ARM: pxa: lubbock: use new pxa_cplds driver

Roger Quadros (1):
      ARM: omap2plus_defconfig: Enable EXTCON_USB_GPIO

Sebastian Reichel (1):
      ARM: dts: omap3: Add #iommu-cells to isp and iva iommu

Shawn Guo (1):
      ARM: dts: imx6qdl-sabreauto: remove pinctrl-assert-gpios

Stefan Wahren (1):
      ARM: dts: imx23-olinuxino: Fix dr_mode of usb0

Suman Anna (1):
      bus: omap_l3_noc: Fix master id address decoding for OMAP5

Tony Lindgren (1):
      ARM: OMAP2+: Fix omap off idle power consumption creeping up

Ulf Hansson (3):
      ARM: ux500: Move GPIO regulator for SD-card into board DTSs
      ARM: ux500: Enable GPIO regulator for SD-card for HREF boards
      ARM: ux500: Enable GPIO regulator for SD-card for snowball

Wolfram Sang (1):
      ARM: mach-imx: devices: platform-sdhci-esdhc-imx: fix broken email address

 CREDITS                                            |   7 +
 .../devicetree/bindings/arm/omap/l3-noc.txt        |   1 +
 .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   2 +-
 MAINTAINERS                                        |  18 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                |   4 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |  11 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |   4 +
 arch/arm/boot/dts/dra7.dtsi                        |  10 +-
 arch/arm/boot/dts/imx23-olinuxino.dts              |   4 +-
 arch/arm/boot/dts/imx25.dtsi                       |   1 +
 arch/arm/boot/dts/imx28.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   2 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   1 -
 arch/arm/boot/dts/omap3-n900.dts                   |   4 +
 arch/arm/boot/dts/omap3.dtsi                       |   2 +
 arch/arm/boot/dts/omap5.dtsi                       |   2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   2 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |  17 --
 arch/arm/boot/dts/ste-href.dtsi                    |  15 ++
 arch/arm/boot/dts/ste-snowball.dts                 |  13 ++
 arch/arm/configs/multi_v7_defconfig                |   3 +
 arch/arm/configs/omap2plus_defconfig               |   2 +-
 .../mach-imx/devices/platform-sdhci-esdhc-imx.c    |   2 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h             |   1 +
 arch/arm/mach-omap2/prm-regbits-44xx.h             |   1 +
 arch/arm/mach-omap2/vc.c                           |  12 +-
 arch/arm/mach-omap2/vc.h                           |   2 +
 arch/arm/mach-omap2/vc3xxx_data.c                  |   1 +
 arch/arm/mach-omap2/vc44xx_data.c                  |   1 +
 arch/arm/mach-pxa/Kconfig                          |   9 +
 arch/arm/mach-pxa/Makefile                         |   1 +
 arch/arm/mach-pxa/include/mach/lubbock.h           |   7 +-
 arch/arm/mach-pxa/include/mach/mainstone.h         |   6 +-
 arch/arm/mach-pxa/lubbock.c                        | 108 +++--------
 arch/arm/mach-pxa/mainstone.c                      | 115 +++---------
 arch/arm/mach-pxa/pxa_cplds_irqs.c                 | 200 +++++++++++++++++++++
 arch/arm/mach-rockchip/pm.c                        |  33 ++++
 arch/arm/mach-rockchip/pm.h                        |   8 +
 arch/arm/mach-rockchip/rockchip.c                  |  19 ++
 drivers/bus/arm-cci.c                              |   2 +-
 drivers/bus/omap_l3_noc.c                          |   5 +-
 drivers/bus/omap_l3_noc.h                          |  54 ++++--
 42 files changed, 480 insertions(+), 234 deletions(-)
 create mode 100644 arch/arm/mach-pxa/pxa_cplds_irqs.c
