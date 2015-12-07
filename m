From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  7 Dec 2015 15:57:27 -0800
Subject: [GIT PULL 2/4] Broadcom devicetree changes for v4.5
In-Reply-To: <1449532649-6471-1-git-send-email-f.fainelli@gmail.com>
References: <1449532649-6471-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1449532649-6471-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.5/devicetree

for you to fetch changes up to f6b889358a82c1f1a34bfcecfe8ebf709deb28ec:

  ARM: dts: Enable MSI support for Broadcom Cygnus (2015-12-07 14:14:40 -0800)

----------------------------------------------------------------
This pull request contains the Broadcom ARM-based Device Tree changes for 4.5:

- Jon Mason enables the following for Broadcom Northstar Plus SoCs: PCI (using
  iProc PCI), NAND flash controller (BRCMNAND), TWD Timer and Watchdog
  (Cortex-A9), I2C (iProc), clock providers, does some Device Tree cleanups
  (re-parenting, fixing register sizes and hierarchy)

- Jon Mason also adds support for some reference Broadcom Northstar reference
  designs like the BCM5301X SVK reference boards, updates the existing binding
  documentation to cover the Northstar chips: 4708, 4709 and 53012.

- Pramod Kumar adds the GPIO to pinctrl mapping for the Broadcom Northstar Plus
  SoCs

- Yendapally Reddy Dhananjaya Reddy adds pinctrl Device Tree nodes for the
  Broadcom Northstar Plus SoCs device tree nodes

- Ray Jui adds Cygnus PCIe PHY Device Tree nodes and enables MSI for the iProc
  PCI controller on Cygnus platforms

- Kapil Hali adds SMP binding documentation and Device Tree nodes for the
  Northstar Plus SoCs

- Florian Fainelli adds clock provider support for the Broadcom BCM63138 DSL
  SoCs by utilizing the existing iProc ARM PLL controller, this includes a
  stable topic branch from Stephen Boyd to be merged

- Rafal Milecki adds missing LEDs for the Netgear R8000 router

----------------------------------------------------------------
Florian Fainelli (3):
      clk: iproc: Extend binding to cover BCM63138
      clk: bcm: Add BCM63138 clock support
      ARM: dts: BCM63xx: Add ARMPLL device tree nodes

Jon Mason (9):
      ARM: dts: NSP: Add PCI support
      ARM: dts: NSP: Add NAND Support to DT
      ARM: dts: NSP: Add TWD Support to DT
      dt-bindings: Add new SoCs to bcm4708 DT bindings
      ARM: dts: bcm5301x: Add BCM SVK DT files
      ARM: dts: NSP: Device Tree clean-ups
      ARM: dts: NSP: Add I2C support to the DT
      ARM: dts: enable clock support for BCM5301X
      ARM: dts: enable clock support for Broadcom NSP

Kapil Hali (2):
      dt-bindings: add SMP enable-method for Broadcom NSP
      ARM: dts: Add SMP support for Broadcom NSP

Pramod Kumar (2):
      dts: pinctrl: Add GPIO to Pinctrl pin mapping in DT
      ARM: dts: Cygnus: define ngpios property in gpio controller's node

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Add missing Netgear R8000 LEDs

Ray Jui (2):
      ARM: dts: enable PCIe PHY support for Cygnus
      ARM: dts: Enable MSI support for Broadcom Cygnus

Yendapally Reddy Dhananjaya Reddy (1):
      ARM: dts: enable pinctrl for Broadcom NSP

 .../devicetree/bindings/arm/bcm/brcm,bcm4708.txt   |   7 +
 .../bindings/arm/bcm/brcm,nsp-cpu-method.txt       |  39 ++++
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../bindings/clock/brcm,iproc-clocks.txt           |   5 +
 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 101 ++++++++-
 arch/arm/boot/dts/bcm-nsp.dtsi                     | 232 +++++++++++++++++++--
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        |  30 +++
 arch/arm/boot/dts/bcm5301x.dtsi                    |  92 ++++++--
 arch/arm/boot/dts/bcm63138.dtsi                    |  36 +++-
 arch/arm/boot/dts/bcm94708.dts                     |  56 +++++
 arch/arm/boot/dts/bcm94709.dts                     |  56 +++++
 arch/arm/boot/dts/bcm953012k.dts                   |  63 ++++++
 arch/arm/boot/dts/bcm958625k.dts                   |  59 ++++++
 drivers/clk/bcm/Kconfig                            |  10 +
 drivers/clk/bcm/Makefile                           |   1 +
 drivers/clk/bcm/clk-bcm63xx.c                      |  22 ++
 17 files changed, 762 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
 create mode 100644 arch/arm/boot/dts/bcm94708.dts
 create mode 100644 arch/arm/boot/dts/bcm94709.dts
 create mode 100644 arch/arm/boot/dts/bcm953012k.dts
 create mode 100644 drivers/clk/bcm/clk-bcm63xx.c
