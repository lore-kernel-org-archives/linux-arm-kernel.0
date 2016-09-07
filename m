From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  6 Sep 2016 18:59:17 -0700
Subject: [GIT PULL 3/4] Broadcom devicetree changes for 4.9
In-Reply-To: <1473213558-11782-1-git-send-email-f.fainelli@gmail.com>
References: <1473213558-11782-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1473213558-11782-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.9/devicetree

for you to fetch changes up to 7260ecd22baa3c62ef6efaf59e7de53f4c8df800:

  Merge tag 'bcm2835-dt-next-2016-08-29' into devicetree/next (2016-08-30 20:02:04 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based Device Tree changes for v4.9,
please pull the following:

- Jon adds support for the Ethernet MAC DT nodes (AMAC) and provides the
  following updates for Broadcom references boards:
  * New Northstar Plus reference boards added: BCM958525er, BCM958522er,
    BCM988312hr, BCM958623hr and BCM958622hr
  * Add SATA nodes to the BCM958625hr and XMC boards
  * Add I2C nodes to the XMC board
  * Fixes the amount of RAM on BCM958625HR, BCM958625K and BCM958525XMC boards
  * Add the GPIO reboot method for BCM958625hr and XMC boards

- Dhanajay adds PWM nodes for the Northstar Plus SoCs

- Rafal adds the USB 2.0 PHY to the BCM5301x Device Tree file include

- Stefan adds a missing USB clock to the BCM283x DT files, adds a DTSI file for
  the USB host mode on BCM283x and finally documents and adds support for the
  Raspberry Pi Zero

- Florian adds support for the Northstar Plus Switch Register Access block which
  enables the integrated switch on these SoCs and enables the switch ports on the
  BCM958625HR reference board

----------------------------------------------------------------
Florian Fainelli (3):
      ARM: dts: NSP: Add Switch Register Access Block node
      ARM: dts: NSP: Add BCM958625HR switch ports
      Merge tag 'bcm2835-dt-next-2016-08-29' into devicetree/next

Jon Mason (14):
      dt-bindings: net: bgmac: add bindings documentation for bgmac
      ARM: dts: NSP: Add AMAC entries
      ARM: dts: NSP: Correct RAM amount for BCM958625HR board
      ARM: dts: NSP: Enable SATA on bcm958625hr
      ARM: dts: NSP: Enable SATA and add i2c devices on XMC
      ARM: dts: NSP: Specify RAM amount for BCM958625K board
      ARM: dts: NSP: Specify RAM amount for BCM958525XMC board
      ARM: dts: NSP: Add GPIO reboot method to bcm958625hr DTS file
      ARM: dts: NSP: Add GPIO reboot method to bcm958625xmc DTS file
      ARM: dts: NSP: Add new DT file for bcm958525er
      ARM: dts: NSP: Add new DT file for bcm958522er
      ARM: dts: NSP: Add new DT file for bcm988312hr
      ARM: dts: NSP: Add new DT file for bcm958623hr
      ARM: dts: NSP: Add new DT file for bcm958622hr

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Specify PHY of USB 2.0 in DT

Stefan Wahren (4):
      ARM: dts: bcm283x: Add missing USB clock
      ARM: dts: bcm283x: Add dtsi for USB host mode
      DT: bindings: bcm: Add Raspberry Pi Zero
      ARM: dts: bcm2835: Add Raspberry Pi Zero

Yendapally Reddy Dhananjaya Reddy (1):
      ARM: dts: NSP: Add PWM Support to DT

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
 .../devicetree/bindings/net/brcm,amac.txt          |  24 +++
 .../devicetree/bindings/net/brcm,bgmac-nsp.txt     |  24 +++
 arch/arm/boot/dts/Makefile                         |   8 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  37 +++++
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   1 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |   1 +
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |  40 +++++
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |   1 +
 arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi        |   3 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   9 +
 arch/arm/boot/dts/bcm5301x.dtsi                    |  11 ++
 arch/arm/boot/dts/bcm958522er.dts                  | 130 +++++++++++++++
 arch/arm/boot/dts/bcm958525er.dts                  | 142 ++++++++++++++++
 arch/arm/boot/dts/bcm958525xmc.dts                 |  44 ++++-
 arch/arm/boot/dts/bcm958622hr.dts                  | 170 +++++++++++++++++++
 arch/arm/boot/dts/bcm958623hr.dts                  | 178 ++++++++++++++++++++
 arch/arm/boot/dts/bcm958625hr.dts                  |  71 +++++++-
 arch/arm/boot/dts/bcm958625k.dts                   |  13 ++
 arch/arm/boot/dts/bcm988312hr.dts                  | 182 +++++++++++++++++++++
 23 files changed, 1093 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/brcm,amac.txt
 create mode 100644 Documentation/devicetree/bindings/net/brcm,bgmac-nsp.txt
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-zero.dts
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958522er.dts
 create mode 100644 arch/arm/boot/dts/bcm958525er.dts
 create mode 100644 arch/arm/boot/dts/bcm958622hr.dts
 create mode 100644 arch/arm/boot/dts/bcm958623hr.dts
 create mode 100644 arch/arm/boot/dts/bcm988312hr.dts
