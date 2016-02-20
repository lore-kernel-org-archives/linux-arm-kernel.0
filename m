From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 20 Feb 2016 11:46:22 -0800
Subject: [GIT PULL 3/8] Broadcom devicetree changes for 4.6
In-Reply-To: <1455997587-17564-1-git-send-email-f.fainelli@gmail.com>
References: <1455997587-17564-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1455997587-17564-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.6/devicetree

for you to fetch changes up to ac07c41c9ad827950795b33f3ca9264288f3b1e4:

  Merge tag 'bcm2835-dt-next-2016-02-17' into devicetree/next (2016-02-20 11:05:55 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs Device Tree changes:

- Rafal adds a Device Tree for the D-Link DIR-885L router which is based on the
  BCM47094 SoC similar to the BCM4709

- Simran adds proper audio clock Device Tree nodes to the Cygnus platforms

- Martin adds the auxiliary SPI controllers, makes the UART naming convention
  more standard, and finally adds the auxiliary UART found in the BCM2835 to the
  BCM2835 Device Tree

- Remi adds PWM clock support to the BCM2835 Device Tree

- Lubomir adds a Device Tree for the Raspberry Pi Model A

- Alexander adds Device Tree information for the Raspberry Pi USB power domain

- Dhananjay enables the GPIO-A controller for the Northstar Plus SoCs

- Jon fixes the PCIE Device Tree nodes by pulling them out of the bus-level node,
  removes duplicate CPU definitions, adds PMU nodes, SP804 timers, and SP805 watchdog
  to the Northstar Plus SoCs

----------------------------------------------------------------
Alexander Aring (1):
      ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2016-02-17' into devicetree/next

Jon Mason (5):
      ARM: dts: NSP: Fix PCIE DT issue
      ARM: dts: NSP: Fix CPU DT issue
      ARM: dts: NSP: Add PMU Support to DT
      ARM: dts: NSP: Add SP804 Support to DT
      ARM: dts: NSP: Add SP805 Support to DT

Lubomir Rintel (1):
      ARM: bcm2835: dt: Add Raspberry Pi Model A

Martin Sperl (3):
      ARM: bcm2835: add the auxiliary spi1 and spi2 to the device tree
      ARM: bcm2835: follow dt uart node-naming convention
      ARM: bcm2835: add bcm2835-aux-uart support to DT

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Add DT for D-Link DIR-885L

Remi Pommarel (1):
      ARM: bcm2835: Add PWM clock support to the device tree

Simran Rai (1):
      ARM: dts: Add audio clock to the existing Broadcom Cygnus clock DT

Yendapally Reddy Dhananjaya Reddy (1):
      ARM: dts: enable GPIO-a for Broadcom NSP

 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/bcm-cygnus-clock.dtsi       |   9 ++
 arch/arm/boot/dts/bcm-nsp.dtsi                | 205 +++++++++++++++-----------
 arch/arm/boot/dts/bcm2835-rpi-a.dts           |  24 +++
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |  16 ++
 arch/arm/boot/dts/bcm283x.dtsi                |  43 +++++-
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts | 111 ++++++++++++++
 7 files changed, 322 insertions(+), 88 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-a.dts
 create mode 100644 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
