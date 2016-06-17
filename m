From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 16 Jun 2016 18:56:11 -0700
Subject: [GIT PULL 3/7] Broadcom devicetree changes for 4.8 Part 1
In-Reply-To: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
References: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1466128575-5378-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/devicetree

for you to fetch changes up to 2df1808dc0e2b5358e13beb95192b15200017776:

  ARM: dts: BCM5310x: Enable switch ports on SmartRG SR400AC (2016-06-13 12:44:46 -0700)

----------------------------------------------------------------
This pull request contains Device Tree changes for Broadcom ARM-based SoCs:

- Chris provides documentation and DTS fixes for the bcm11351 CPU enable-method in preparation
  for adding support for the BCM23550 SoC and its corresponding documentation, SoC dtsi
  and the Sparrow board DTS file

- Jon adds MSI support to the PCI nodes, updates the secondary cores boot address for the B0
  production revision of the Northstar Plus SoC, adds a DTS for the BCM958625HR board, another
  one for the BCM958525XMC board, and finally adds the PL330 DMA controller to the NSP DTS

- Rafal enables the SPI NOR flash on dual flash systems (NAND + SPI) on the BCM5301x SoCs
  and devices

- Florian adds support for the BCM5301x built-in Ethernet switch by adding nodes for the
  Gigabit MAC controllers and the Switch Register Access block, and finally updates the
  SmartRG SR-400AC board with its switch port layout

----------------------------------------------------------------
Chris Brand (5):
      Documentation: Binding docs for bcm11351 enable method
      ARM: dts: fix use of bcm11351 enable method
      ARM: BCM: modify Broadcom CPU enable method
      Documentation: devicetree: Document BCM23550 bindings
      ARM: dts: bcm23550: Add device tree files

Florian Fainelli (3):
      ARM: dts: Enable SRAB switch and GMACs on 5301x DTS
      ARM: dts: BCM5301X: Add SRAB interrupts
      ARM: dts: BCM5310x: Enable switch ports on SmartRG SR400AC

Jon Mason (5):
      ARM: dts: NSP: Add MSI support on PCI
      ARM: dts: NSP: modify second CPU address
      ARM: dts: NSP: Add new DT file for bcm958625hr
      ARM: dts: NSP: Add XMC board support
      ARM: dts: NSP: Add PL330 support

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Enable SPI-NOR on dual flash devices

 .../bindings/arm/bcm/brcm,bcm11351-cpu-method.txt  |   6 +-
 .../bindings/arm/bcm/brcm,bcm23550-cpu-method.txt  |  36 ++
 .../devicetree/bindings/arm/bcm/brcm,bcm23550.txt  |  15 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   2 +
 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  55 ++-
 arch/arm/boot/dts/bcm11351.dtsi                    |   2 +-
 arch/arm/boot/dts/bcm21664.dtsi                    |   2 +-
 arch/arm/boot/dts/bcm23550-sparrow.dts             |  80 ++++
 arch/arm/boot/dts/bcm23550.dtsi                    | 415 +++++++++++++++++++++
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |   4 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |   4 +
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     |   4 +
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |  40 ++
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |   4 +
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |   4 +
 arch/arm/boot/dts/bcm5301x.dtsi                    |  42 +++
 arch/arm/boot/dts/bcm958525xmc.dts                 | 109 ++++++
 arch/arm/boot/dts/bcm958625hr.dts                  | 107 ++++++
 arch/arm/mach-bcm/platsmp.c                        | 116 ++----
 20 files changed, 966 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
 create mode 100644 arch/arm/boot/dts/bcm23550-sparrow.dts
 create mode 100644 arch/arm/boot/dts/bcm23550.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958525xmc.dts
 create mode 100644 arch/arm/boot/dts/bcm958625hr.dts
