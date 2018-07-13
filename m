From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 13 Jul 2018 07:38:18 -0700
Subject: [GIT PULL 3/6 v2] Broadcom devicetree changes for 4.19
In-Reply-To: <20180713143821.1514-1-f.fainelli@gmail.com>
References: <20180713143821.1514-1-f.fainelli@gmail.com>
Message-ID: <20180713143821.1514-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.19/devicetree

for you to fetch changes up to 3be77fe8c3f138cbab68d9c745c2038607286b24:

  Merge tag 'bcm2835-dt-next-2018-07-03' into devicetree/next (2018-07-09 08:12:15 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs Device Tree changes
for 4.19, please pull the following:

- Clement adds ethernet aliases to the Cygnus DTS include file such that
  a DT aware bootloader such as u-boot can properly insert MAC addresses

- Mohamed adds a Device Tree node for the HWRNG found on Cygnus SoCs

- Vivek migrates all the BCM5301x (Northstar) Device Tree sources to use
  the proper USB 3.0 PHY representation using its parent MDIO bus.
  Vivek also completes the Linksys EA9500 Device Tree by adding support
  for LEDs, internal and external switches.

- Rafal adds the ARM architected timer to the BCM53573 Device Tree
  include file.

- Eric adds the Performance Monitoring Unit to the BCM2837 DTS include
  file since it was absent before

- Boris adds the BCM283x transposer block to the Device Tree

- Stefan adds the Raspberry Pi Compute Module (CM1) Device Tree include
  and sources.

----------------------------------------------------------------
Boris Brezillon (1):
      ARM: dts: bcm283x: Add Transposer block

Cl?ment P?ron (1):
      ARM: dts: cygnus: add ethernet0 alias

Eric Anholt (1):
      ARM: dts: bcm283x: Add the PMU to the devicetree.

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2018-07-03' into devicetree/next

Mohamed Ismail Abdul Packir Mohamed (1):
      ARM: dts: cygnus: enable iproc-hwrng

Rafa? Mi?ecki (1):
      ARM: dts: BCM53573: Add architected timer

Stefan Wahren (1):
      ARM: dts: add Raspberry Pi Compute Module and IO board

Vivek Unune (2):
      ARM: dts: BCM5301X: Make USB 3.0 PHY use MDIO PHY driver
      ARM: dts: BCM5301X: Add support for Linksys EA9500

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   9 +
 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts          |  88 ++++++++
 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi             |  34 +++
 arch/arm/boot/dts/bcm2837.dtsi                     |   6 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   6 +
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        |   4 +
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        |   4 +
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |   4 +
 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts    |   4 +
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       |   4 +
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |   4 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |   4 +
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     |   4 +
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |   4 +
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        |   4 +
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts |   4 +
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  |   4 +
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts      |   4 +
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts      |   4 +
 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts |   4 +
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        |   4 +
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |   4 +
 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts       |   4 +
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts        |   4 +
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        |   4 +
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  |   4 +
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |   4 +
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts    | 233 +++++++++++++++++++++
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts      |   4 +
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts      |   4 +
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |   4 +
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts       |   4 +
 arch/arm/boot/dts/bcm47094.dtsi                    |   7 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |  35 +++-
 arch/arm/boot/dts/bcm53573.dtsi                    |   8 +
 arch/arm/boot/dts/bcm94708.dts                     |   4 +
 arch/arm/boot/dts/bcm94709.dts                     |   4 +
 arch/arm/boot/dts/bcm953012er.dts                  |   4 +
 arch/arm/boot/dts/bcm953012hr.dts                  |   4 +
 arch/arm/boot/dts/bcm953012k.dts                   |   4 +
 41 files changed, 540 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
