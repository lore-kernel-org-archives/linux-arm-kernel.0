From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  2 Oct 2015 15:20:56 -0700
Subject: [GIT PULL] Broadcom devicetree changes for v4.4
In-Reply-To: <1443824458-20799-1-git-send-email-f.fainelli@gmail.com>
References: <1443824458-20799-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1443824458-20799-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.4/devicetree

for you to fetch changes up to eef228e3191de0b62ef5913be216f25ba6b23a4c:

  ARM: dts: move aliases back to .dts in Cygnus (2015-09-24 18:30:10 -0700)

----------------------------------------------------------------
This pull requests contains the following Broadcom SoCs Device Tree changes:

- Brian Norris documents the BCM7445 SoCs Power Management controllers and
  hardware and updates the reference BCM7445 Device Tree with these nodes

- Florian Fainelli documents the BCM7xxx write-pairing feature in the top-level
  BCM7xxx binding document

- Hauke Merthens enables the NAND controller for the Asus RT-AC87U and adds the
  GPIO pin controlling the USB power supply on Netgear R6250

- Jon Mason adds support for the NorthStar Plus SoC by providing a top-level
  binding document and the minimalist device tree skeleton for these SoCs

- Rafal Milecki adds support for the Netgear R7000 (BCM5301x SoC)

- Ray Jui provides a set of Cygnus DT changes that make the Device Tree clearer
  and more correct with respect to how the hardware is designed. He also enables
  the NAND controller on the bcm911360_entphn design, enables a bunch of
  peripherals on the bcm958305k evaluation board, and adds a skeleton .dtsi file
  for the touchscreen extansion board(s)

----------------------------------------------------------------
Brian Norris (2):
      Documentation: dt: brcmstb: add system PM bindings
      ARM: dts: brcmstb: add BCM7445 system PM DT nodes

Florian Fainelli (1):
      Documentation: bindings: brcmstb: Document write-pairing

Hauke Mehrtens (2):
      ARM: BCM5301X: add NAND flash chip description for Asus RT-AC87U
      ARM: BCM5301X: Netgear R6250 add USB GPIO

Jon Mason (2):
      dt-bindings: Create Documentation for NSP DT bindings
      ARM: NSP: add minimal Northstar Plus device tree

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Add DT for Netgear R7000

Ray Jui (10):
      ARM: dts: consolidate aliases for Cygnus dt files
      ARM: dts: Use label for device nodes in Cygnus dts
      ARM: dts: Put Cygnus core components under core bus
      ARM: dts: Move all Cygnus peripherals into axi bus
      ARM: dts: Reorder Cygnus peripherals
      ARM: dts: Enable various peripherals on bcm958305k
      ARM: dts: Enable NAND support on bcm911360_entphn
      ARM: dts: enable touchscreen support on Cygnus
      ARM: dts: fix Cygnus nand device node
      ARM: dts: move aliases back to .dts in Cygnus

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   | 162 +++++++++-
 .../devicetree/bindings/arm/bcm/brcm,nsp.txt       |  34 +++
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 334 +++++++++++----------
 arch/arm/boot/dts/bcm-nsp.dtsi                     | 119 ++++++++
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |  11 +
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        |   1 +
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts        | 106 +++++++
 arch/arm/boot/dts/bcm7445.dtsi                     |  84 ++++++
 arch/arm/boot/dts/bcm911360_entphn.dts             |  28 +-
 arch/arm/boot/dts/bcm911360k.dts                   |   9 +-
 arch/arm/boot/dts/bcm958300k.dts                   |  44 +--
 arch/arm/boot/dts/bcm958305k.dts                   |  40 ++-
 arch/arm/boot/dts/bcm958625k.dts                   |  57 ++++
 arch/arm/boot/dts/bcm9hmidc.dtsi                   |  42 +++
 15 files changed, 874 insertions(+), 200 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt
 create mode 100644 arch/arm/boot/dts/bcm-nsp.dtsi
 create mode 100644 arch/arm/boot/dts/bcm4709-netgear-r7000.dts
 create mode 100644 arch/arm/boot/dts/bcm958625k.dts
 create mode 100644 arch/arm/boot/dts/bcm9hmidc.dtsi
