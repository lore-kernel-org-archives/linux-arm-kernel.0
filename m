From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Jan 2017 17:25:53 -0800
Subject: [GIT PULL 1/2] Broadcom devicetree changes for 4.11 (try 2)
In-Reply-To: <20170119003025.GL23725@localhost>
References: <20170119003025.GL23725@localhost>
Message-ID: <20170119012553.2844-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.11/devicetree

for you to fetch changes up to c5a8e3add28ca4063410353acfbe6e650174e432:

  Merge tag 'bcm2835-dt-next-2017-01-17' into devicetree/next (2017-01-18 17:20:32 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC Device Tree changes for 4.11,
please pull the following changes:

- Rafal enables the UART by default on all BCM5301x, BCM4708, BCM4709 since
  every device found out there has it enabled by default. He also fixes the
  LED definitions for the Luxul XWR-3100 device, enables USB controllers and
  their respective PHY devices, specifies the correct GPIO to power on USB
  HUBs, adds the additional RAM bank for somes devices, and finally sets the
  correct 5Ghz frequency limits on the Netgear R8000

- Jon does a number of Norsthar Plus SoC cleanups, fixes NAND partitions unit
  addresses, adds QSPI support to a bunch of boards, adds Ethernet switch ports
  to the BCM958625K reference board, enables 3rd Ethernet MAC instance to
  relevant DTSes, enables Ethernet on the XMC board, and finally adds SD/MMC
  support to the XMC board

- Boris adds the Video Encoder nodes to the Raspberry Pi DTS include files
  ands enables it on the relevant boards

- Dan adds support for two new Luxul devices: XAP-1410 and XWR-1200, both
  BCM47081 based SoCs

----------------------------------------------------------------
Boris Brezillon (2):
      ARM: dts: bcm283x: Add VEC node in bcm283x.dtsi
      ARM: dts: bcm283x: Enable the VEC IP on all RaspberryPi boards

Dan Haab (2):
      ARM: dts: BCM5301X: Add DT for Luxul XAP-1410
      ARM: dts: BCM5301X: Add DT for Luxul XWR-1200

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2017-01-17' into devicetree/next

Jon Mason (7):
      ARM: dts: NSP: DT Clean-ups
      ARM: dts: NSP: Correct NAND partition unit address
      ARM: dts: NSP: Add QSPI support to missing boards
      ARM: dts: NSP: Add BCM958625K switch ports
      ARM: dts: NSP: Add and enable amac2
      ARM: dts: NSP: Add Ethernet to NSP XMC
      ARM: dts: NSP: Add SD/MMC support

Rafa? Mi?ecki (7):
      ARM: dts: BCM5301X: Enable UART by default for BCM4708(1), BCM4709(4) & BCM53012
      ARM: dts: BCM5301X: Fix LAN LED labels for Luxul XWR-3100
      ARM: dts: BCM5301X: Specify USB controllers in DT
      ARM: dts: BCM5301X: Set GPIO enabling USB power on Netgear R7000
      ARM: dts: BCM5301X: Specify all RAM by including an extra block
      ARM: dts: BCM53573: Specify USB ports of on-SoC controllers
      ARM: dts: BCM5301X: Set 5 GHz wireless frequency limits on Netgear R8000

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  64 +++++----
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   5 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   8 ++
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        |   3 +-
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        |   3 +-
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |   7 +-
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       |   4 -
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |   4 -
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |   7 +-
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     |   3 +-
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |   7 +-
 arch/arm/boot/dts/bcm4708.dtsi                     |   4 +
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        |   3 +-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts |   7 +-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  |   3 +-
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts      |  60 ++++++++
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts      | 107 +++++++++++++++
 arch/arm/boot/dts/bcm47081.dtsi                    |   4 +
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        |   3 +-
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |   3 +-
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts        |  11 +-
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        |  51 ++++++-
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  |   4 -
 arch/arm/boot/dts/bcm4709.dtsi                     |   1 +
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |   7 +-
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |  13 +-
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts       |   7 +-
 arch/arm/boot/dts/bcm47094.dtsi                    |   1 +
 arch/arm/boot/dts/bcm5301x.dtsi                    |  41 +++++-
 arch/arm/boot/dts/bcm53573.dtsi                    |  22 +++
 arch/arm/boot/dts/bcm94708.dts                     |   4 -
 arch/arm/boot/dts/bcm94709.dts                     |   4 -
 arch/arm/boot/dts/bcm953012er.dts                  |   4 -
 arch/arm/boot/dts/bcm953012k.dts                   |   1 -
 arch/arm/boot/dts/bcm958522er.dts                  |  35 ++++-
 arch/arm/boot/dts/bcm958525er.dts                  |  35 ++++-
 arch/arm/boot/dts/bcm958525xmc.dts                 |  68 ++++++++--
 arch/arm/boot/dts/bcm958622hr.dts                  |  42 ++++++
 arch/arm/boot/dts/bcm958623hr.dts                  |  58 ++++++--
 arch/arm/boot/dts/bcm958625hr.dts                  |  72 ++++++++--
 arch/arm/boot/dts/bcm958625k.dts                   | 151 ++++++++++++++++-----
 arch/arm/boot/dts/bcm988312hr.dts                  |  42 ++++++
 43 files changed, 813 insertions(+), 172 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
 create mode 100644 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
