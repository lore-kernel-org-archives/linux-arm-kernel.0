From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 11 May 2018 14:43:36 -0700
Subject: [GIT PULL 3/5] Broadcom devicetree changes for 4.18
In-Reply-To: <20180511214339.24139-1-f.fainelli@gmail.com>
References: <20180511214339.24139-1-f.fainelli@gmail.com>
Message-ID: <20180511214339.24139-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.18/devicetree

for you to fetch changes up to a05f1e36a57d02374a203719abc5bf2e8c51e125:

  ARM: dts: BCM5301X: Switch D-Link DIR-885L to the new partitions syntax (2018-05-11 09:46:38 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC Device Tree changes
for 4.18, please pull the following:

- Stefan provides updates to the BCM2835 RNG Device Tree binding and
  Device Tree node by adding its missing interrupt line.

- Rafal switches the Luxul XWC-1000 and the D-Link DIR-885L to the new
  partitions syntax which allows specifying a partition parser

- Rafal also updates a bunch of BCM5301X Device Tree source files to a
  more standard SPDX tag and dual GPL 2.0 and MIT. This is a follow-up
  to this discussion with Greg:
  https://lkml.org/lkml/2018/4/28/179

- Dan adds support for two Luxul devices: XAP-1610 (based on BCM47094)
  and XWR-3150 V1 (similar to XWR-3100)

- Stefan provides a set of updates to the BCM283x Device Tree sources to
  support the Raspberry Pi 3 B+ for both the ARM and ARM64 kernels. He
  adds the required nodes for the LAN7515 USB Ethernet, Cypress CYW43455
  BT/WiFi combo chip. Stefan also provides a few fixes for the PWM pin
  assignment for RPi 3B and Zero/Zero W. Finally, Stefan adds the
  missing GPIOs for controlling additional peripherals now that support
  for the RPi 3 GPIO expander has landed

----------------------------------------------------------------
Dan Haab (2):
      ARM: dts: BCM5301X: Add DT for Luxul XWR-3150 V1
      ARM: dts: BCM5301X: Add DT for Luxul XAP-1610

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2018-04-30' into devicetree/next

Rafa? Mi?ecki (5):
      ARM: dts: BCM5301X: Switch Luxul XWC-1000 to the new fixed partitions syntax
      ARM: dts: BCM5301X: Relicense most DTS files to the GPL 2.0+ / MIT
      ARM: dts: BCM5301X: Relicense Buffalo files to the GPL 2.0+ / MIT
      ARM: dts: BCM5301X: Relicense Asus RT-AC87U file to the GPL 2.0+ / MIT
      ARM: dts: BCM5301X: Switch D-Link DIR-885L to the new partitions syntax

Stefan Wahren (7):
      dt-binding: rng: Add interrupt property for BCM2835
      ARM: bcm283x: Add missing interrupt for RNG block
      ARM: dts: bcm283x: Fix PWM pin assignment
      ARM: dts: bcm2837: Add missing GPIOs of Expander
      dt-bindings: bcm: Add Raspberry Pi 3 B+
      ARM: dts: bcm2837: Add Raspberry Pi 3 B+
      arm64: dts: broadcom: Add reference to Raspberry Pi 3 B+

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
 .../devicetree/bindings/rng/brcm,bcm2835.txt       |   9 +-
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   6 ++
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |   6 ++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |   6 ++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |   6 ++
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |   6 ++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   6 --
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |   6 ++
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         | 108 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  26 ++++-
 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi         |  27 ++++++
 arch/arm/boot/dts/bcm283x.dtsi                     |   1 +
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        |  13 +--
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        |  13 +--
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |   3 +-
 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts    |   3 +-
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       |   3 +-
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |  15 ++-
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     |  13 +--
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |   3 +-
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        |  13 +--
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts |  13 +--
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  |  13 +--
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts      |   3 +-
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts      |   3 +-
 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts |   3 +-
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        |  13 +--
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |   3 +-
 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts       |   3 +-
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts        |  13 +--
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  |   3 +-
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |  25 ++---
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts    |   3 +-
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts      |   3 +-
 arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts      |  57 +++++++++++
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts      |   3 +-
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |   3 +-
 arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts   |  77 +++++++++++++++
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts       |   3 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi      |   3 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi      |   3 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi      |   3 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi           |   3 +-
 arch/arm64/boot/dts/broadcom/Makefile              |   3 +-
 .../boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts     |   2 +
 47 files changed, 396 insertions(+), 164 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
 create mode 100644 arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts
 create mode 100644 arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts
