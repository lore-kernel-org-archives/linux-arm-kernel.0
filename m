From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 14 Sep 2018 16:59:27 -0700
Subject: [GIT PULL 2/3] Broadcom devicetree changes for 4.20
In-Reply-To: <20180914235928.20551-1-f.fainelli@gmail.com>
References: <20180914235928.20551-1-f.fainelli@gmail.com>
Message-ID: <20180914235928.20551-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.20/devicetree

for you to fetch changes up to ab0b47d2eff413d60b0a1fc0c1f87f87f0d7f375:

  ARM: dts: bcm: Fix SPI bus warnings (2018-09-13 15:09:10 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs Device Tree changes
for 4.20, please pull the following:

- Rafal updates the Broadcom BCM5301x (Northstar) DTS files to use the
  new style partition parser and removes the unsupported/undocumented
  linux,part-probe properties that were previously introduced

- Stefan adds supports for the Raspberry Pi Compute Module 3/3Lite, he
  also updates the Raspberry Pi 3B+ USB Ethernet adapter to have proper
  LED configuration

- Rob fixes a bunch of SPI bus warnings in the Northstar Plus and
  Hurricane 2 DTS files

- Florian documents the Broadcom roboswitch Switch Register Access Block
  (SRAB) interrupts, adds the switch interrupts to the Northstar Plus
  DTS include file and finally updates the BCM958625HR reference board to
  have the proper SFP module definition

----------------------------------------------------------------
Florian Fainelli (4):
      ARM: dts: NSP: Enable SFP on bcm958625hr
      dt-bindings: net: dsa: Document B53 SRAB interrupts and registers
      ARM: dts: NSP: Wire up switch interrupts
      Merge tag 'tags/bcm2835-dt-next-2018-09-09' into devicetree/next

Rafa? Mi?ecki (1):
      ARM: dts: BCM5301X: Specify flash partitions

Rob Herring (1):
      ARM: dts: bcm: Fix SPI bus warnings

Stefan Wahren (3):
      dt-bindings: bcm: Add Raspberry Pi CM3 and CM3L
      ARM: dts: add Raspberry Pi Compute Module 3 and IO board
      ARM: dts: bcm283x-rpi-lan7515: Enable Ethernet LEDs

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  8 ++
 Documentation/devicetree/bindings/net/dsa/b53.txt  | 36 +++++++++
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/bcm-hr2.dtsi                     |  2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     | 33 +++++++-
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts          | 87 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             | 52 +++++++++++++
 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi         | 14 ++++
 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts | 28 +++++++
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        | 31 ++++++++
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  | 28 +++++++
 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi           |  4 +
 arch/arm/boot/dts/bcm5301x.dtsi                    |  5 +-
 arch/arm/boot/dts/bcm958625hr.dts                  | 26 +++++++
 14 files changed, 351 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
