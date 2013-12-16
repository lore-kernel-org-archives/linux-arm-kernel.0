From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 16 Dec 2013 15:00:44 +0100
Subject: [GIT PULL] ARM: Initial support for Marvell Berlin SoCs
Message-ID: <1387202444-7270-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear ARM maintainers,

please pull the initial support patches for Marvell Berlin SoCs.
While this is the initial PR, it is not yet split up into the
usual sub-branches. If you require it, please request it.

Compared to the last patch set sent on list, the branch below:
- does not contain Tauros3 patch which has been submitted to
  rmk's patch system separately [1].
- went back to soc-board.dts[i] naming as mentioned by Olof.

[1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7922/1

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:
  https://github.com/shesselba/linux-berlin.git topic/initial-for-v3.14

for you to fetch changes up to 1c37fa10b275d3e5b6285066b5b27c8feae688c8:

  ARM: add initial support for Marvell Berlin SoCs (2013-09-09 14:36:19 +0200)

----------------------------------------------------------------

Initial support for Marvell Berlin SoCs, e.g. Armada 1500 and
Armada 1500-mini, found on various consumer devices like Google Chromecast
and GoogleTV.

----------------------------------------------------------------

Sebastian Hesselbarth (8):
      irqchip: add DesignWare APB ICTL interrupt controller
      MAINTAINERS: add ARM Marvell Berlin SoC
      ARM: add Marvell Berlin SoC familiy to Marvell doc
      ARM: add Marvell Berlin SoCs to multi_v7_defconfig
      ARM: add Marvell Berlin UART0 lowlevel debug
      ARM: add Armada 1500 and Sony NSZ-GS7 device tree files
      ARM: add Armada 1500-mini and Chromecast device tree files
      ARM: add initial support for Marvell Berlin SoCs

 Documentation/arm/Marvell/README                   |   24 ++
 .../devicetree/bindings/arm/marvell,berlin.txt     |   24 ++
 .../interrupt-controller/snps,dw-apb-ictl.txt      |   32 +++
 MAINTAINERS                                        |    6 +
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Kconfig.debug                             |   10 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/Makefile                         |    3 +
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts         |   29 +++
 arch/arm/boot/dts/berlin2.dtsi                     |  227 ++++++++++++++++++++
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts  |   29 +++
 arch/arm/boot/dts/berlin2cd.dtsi                   |  210 ++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |    3 +
 arch/arm/mach-berlin/Kconfig                       |   29 +++
 arch/arm/mach-berlin/Makefile                      |    1 +
 arch/arm/mach-berlin/berlin.c                      |   39 ++++
 drivers/irqchip/Kconfig                            |    4 +
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-dw-apb-ictl.c                  |  150 +++++++++++++
 19 files changed, 824 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell,berlin.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
 create mode 100644 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
 create mode 100644 arch/arm/boot/dts/berlin2.dtsi
 create mode 100644 arch/arm/boot/dts/berlin2cd-google-chromecast.dts
 create mode 100644 arch/arm/boot/dts/berlin2cd.dtsi
 create mode 100644 arch/arm/mach-berlin/Kconfig
 create mode 100644 arch/arm/mach-berlin/Makefile
 create mode 100644 arch/arm/mach-berlin/berlin.c
 create mode 100644 drivers/irqchip/irq-dw-apb-ictl.c
