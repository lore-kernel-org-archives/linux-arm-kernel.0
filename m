From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 30 Sep 2016 12:23:12 -0700
Subject: [GIT PULL 1/4] Broadcom devicetree changes for 4.9 (part 2)
Message-ID: <1475263395-27653-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7260ecd22baa3c62ef6efaf59e7de53f4c8df800:

  Merge tag 'bcm2835-dt-next-2016-08-29' into devicetree/next (2016-08-30 20:02:04 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.9/devicetree-part2

for you to fetch changes up to ef3bc318adeb15b38688df6a583bafea2befce43:

  ARM: BCM5301X: Add DT for Luxul XWR-3100 (2016-09-30 11:58:31 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs Device Tree changes for 4.9,
please pull the following:

- Rafal adds support for the Netgear R8500 routers, adds basic support
  for the Tenda AC9 router which uses the new BCM53573 SoC (single core Cortex
  A7). He also enables the UART on the Netgear R8000 and restructures the
  include files a bit for the BCM47094 SoC, finally he adds USB 3.0 PHY nodes
  which enables USB 3.0 on BCM5301X devices that support it

- Kamal adds support for the QSPI controller on the Northstar Plus SoCs and updates
  the bcm958625k reference board to have it enabled

- Dan adds support for the Luxul XAP-1510 and XWR-3100 devices

----------------------------------------------------------------
Dan Haab (2):
      ARM: BCM5301X: Add DT for Luxul XAP-1510
      ARM: BCM5301X: Add DT for Luxul XWR-3100

Kamal Dasu (1):
      ARM: dts: NSP: Add QSPI nodes to NSPI and bcm958625k DTSes

Rafa? Mi?ecki (5):
      ARM: BCM5301X: Add DT for Netgear R8500
      ARM: BCM5301X: Add basic dts for BCM53573 based Tenda AC9
      ARM: BCM5301X: Add separated DTS include file for BCM47094
      ARM: BCM5301X: Enable UART on Netgear R8000
      ARM: BCM5301X: Specify USB 3.0 PHY in DT

 arch/arm/boot/dts/Makefile                        |   5 +
 arch/arm/boot/dts/bcm-nsp.dtsi                    |  31 ++++-
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts      |  64 ++++++++++
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts       |   2 +-
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts |   2 +-
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts       |   2 +-
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts       |   6 +-
 arch/arm/boot/dts/bcm4709.dtsi                    |  11 ++
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts     |   3 +-
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts     | 111 ++++++++++++++++
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts      | 103 +++++++++++++++
 arch/arm/boot/dts/bcm47094.dtsi                   |  17 +++
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts          |  74 +++++++++++
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi     |  13 ++
 arch/arm/boot/dts/bcm5301x.dtsi                   |   7 ++
 arch/arm/boot/dts/bcm53573.dtsi                   | 147 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm958625k.dts                  |  34 +++++
 17 files changed, 625 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
 create mode 100644 arch/arm/boot/dts/bcm4709.dtsi
 create mode 100644 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
 create mode 100644 arch/arm/boot/dts/bcm47094-netgear-r8500.dts
 create mode 100644 arch/arm/boot/dts/bcm47094.dtsi
 create mode 100644 arch/arm/boot/dts/bcm47189-tenda-ac9.dts
 create mode 100644 arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi
 create mode 100644 arch/arm/boot/dts/bcm53573.dtsi
