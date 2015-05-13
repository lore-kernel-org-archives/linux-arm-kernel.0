From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 May 2015 15:34:11 -0700
Subject: [GIT PULL] Broadcom Device Tree changes for 4.2
Message-ID: <1431556453-11633-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.2/dts

for you to fetch changes up to 16dc3bac722252a10e396546f44135ae1b6a7ff3:

  ARM: BCM5301X: Add DT for Asus RT-AC56U (2015-05-13 11:32:24 -0700)

----------------------------------------------------------------
This pull request contains the following Device Tree changes:

New devices:

- Felix adds support for the Buffalo WXR-1900DHP and adds the USB led on Buffalo
  WZR-1750DHP

- Rafal adds support for the SmartRG SR400ac, Asus RT-AC68U and RT-AC56U

New peripheral support:

- Brian adds Device Tree nodes for the Broadcom NAND controller found on
  BCM7xxx, BCM63138 and Cygnus SoCs

- Brian adds Device Tree nodes for the SATA AHCI and PHY controller found on
  BCM7xxx

- I add the Device Tree nodes and bindings documents for bringing-up secondary
  CPUs and timer/syscon-reboot on BCM63138

----------------------------------------------------------------
Brian Norris (3):
      ARM: bcm7445: add NAND to DTS
      ARM: bcm63138: add NAND DT support
      ARM: dts: brcmstb: add nodes for SATA controller and PHY

Felix Fietkau (2):
      ARM: BCM5301X: Add USB LED for Buffalo WZR-1750DHP
      ARM: BCM5301X: Add DT for Buffalo WXR-1900DHP

Florian Fainelli (6):
      Documentation: DT: Add Broadcom BCM63138 PMB binding
      ARM: dts: BCM63xx: Add PMB busses nodes
      Documentation: DT: Document SMP DT nodes and properties for BCM63138
      ARM: dts: BCM63xx: Add SMP nodes and required properties
      dt-bindings: Add documentation for the BCM63138 timer and syscon-reboot
      ARM: dts: BCM63xx: Add timer and syscon-reboot nodes

Rafa? Mi?ecki (3):
      ARM: BCM5301X: Add DT for SmartRG SR400ac
      ARM: BCM5301X: Add DT for Asus RT-AC68U
      ARM: BCM5301X: Add DT for Asus RT-AC56U

Ray Jui (1):
      ARM: dts: cygnus: Enable NAND support for Cygnus

 .../devicetree/bindings/arm/bcm/brcm,bcm63138.txt  |  76 ++++++++++++
 .../bindings/reset/brcm,bcm63138-pmb.txt           |  19 +++
 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  12 ++
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        |  96 ++++++++++++++++
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        |  83 ++++++++++++++
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |   6 +
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      | 119 +++++++++++++++++++
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  | 127 +++++++++++++++++++++
 arch/arm/boot/dts/bcm63138.dtsi                    |  43 +++++++
 arch/arm/boot/dts/bcm7445-bcm97445svmb.dts         |  23 ++++
 arch/arm/boot/dts/bcm7445.dtsi                     |  59 ++++++++++
 arch/arm/boot/dts/bcm958300k.dts                   |  16 +++
 arch/arm/boot/dts/bcm963138dvt.dts                 |  12 ++
 14 files changed, 695 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt
 create mode 100644 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
 create mode 100644 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
 create mode 100644 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
 create mode 100644 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
