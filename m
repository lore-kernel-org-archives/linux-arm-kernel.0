From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 Oct 2017 17:16:33 -0700
Subject: [GIT PULL 2/5] Broadcom devicetree changes for 4.15
In-Reply-To: <20171021001636.17662-1-f.fainelli@gmail.com>
References: <20171021001636.17662-1-f.fainelli@gmail.com>
Message-ID: <20171021001636.17662-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.15/devicetree

for you to fetch changes up to bc79cce741fab70968141c67974f8e99e31aec47:

  ARM: dts: Hurricane 2: Add basic support for Ubiquiti UniFi Switch 8 (2017-10-12 11:31:24 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based Device Tree changes for 4.15,
please pull the following:

- Eric adds support for the CLCD and PWM controller on Cygnus chis

- Loic fixes the console path on the Raspberry Pi 3 (already submitted as
  fixes) and then proceeds with enabling the BCM43438 bluetooth chip on
  the Raspberry Pi 3

- Rafal specifies the USB ports on the Luxul XWR-1200

- Dan adds support for the Luxul ABR-4500 based on BCM47094, the Luxul XAP-810
  and XAP-1440 both based on BCM53573

- Florian adds support for the Broadcom Hurricane 2 SoC by adding general
  machine binding, clock binding, SoC DTS include file and a DTS for the
  Ubiquiti Networks UniFi Switch 8

----------------------------------------------------------------
Dan Haab (4):
      ARM: dts: BCM5301X: Add DT for Luxul XBR-4500
      ARM: dts: BCM5301X: Add DT for Luxul ABR-4500
      ARM: dts: BCM53573: Add DT for Luxul XAP-810
      ARM: dts: BCM53573: Add DT for Luxul XAP-1440

Eric Anholt (2):
      ARM: dts: cygnus: Add the CLCD controller
      ARM: dts: cygnus: Add the PWM node

Florian Fainelli (7):
      Merge tag 'bcm2835-dt-fixes-2017-10-06' into devicetree/next
      Merge tag 'bcm2835-dt-next-2017-10-06' into devicetree/next
      dt-bindings: Add documentation for Broadcom Hurricane 2 SoCs
      dt-bindings: Document Broadcom Hurricane 2 clocks
      ARM: dts: Add Broadcom Hurricane 2 DTS include file
      dt-bindings: Add Ubiquiti Networks vendor prefix
      ARM: dts: Hurricane 2: Add basic support for Ubiquiti UniFi Switch 8

Loic Poulain (2):
      ARM: dts: bcm283x: Fix console path on RPi3
      ARM: dts: bcm2837-rpi-3-b: Add bcm43438 serial slave

Rafa? Mi?ecki (1):
      ARM: dts: BCM5301X: Specify USB ports for USB LED of Luxul XWR-1200

 .../devicetree/bindings/arm/bcm/brcm,hr2.txt       |  14 +
 .../bindings/clock/brcm,iproc-clocks.txt           |  14 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   6 +
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  18 +
 arch/arm/boot/dts/bcm-hr2.dtsi                     | 368 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |   9 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  10 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   7 +-
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts      |   3 +-
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts      |  63 ++++
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts      |  63 ++++
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts      |  50 +++
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts       |  87 +++++
 arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts  |  85 +++++
 15 files changed, 790 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt
 create mode 100644 arch/arm/boot/dts/bcm-hr2.dtsi
 create mode 100644 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
 create mode 100644 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
 create mode 100644 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
 create mode 100644 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
 create mode 100644 arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts
