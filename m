From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 1 Nov 2012 15:17:09 +0100
Subject: [GIT PULL] Next batch of ux500 related patches due for -next
Message-ID: <20121101141709.GA14016@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

  Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ljones/linux-3.0-ux500.git ste-dt-for-next

for you to fetch changes up to f44c5fd12d8152e45585905422d03427754e1907:

  ARM: ux500: Convert DT_MACHINE_START to use SMP operations (2012-11-01 13:02:28 +0100)

----------------------------------------------------------------
Lee Jones (31):
      ARM: ux500: Move regulator-name properties out to board DTS files
      ARM: ux500: Fix initialisation order for UIBs
      ARM: ux500: Elaborate on SDI device node names in Device Tree
      ARM: ux500: Add SDI (MMC) support to the HREF Device Tree
      ARM: ux500: Correct Snowball's external SD/MMC slot's bus width
      ARM: ux500: Create a DTS hierarchy for ST-Ericsson's HREF boards
      ARM: ux500: Create a Device Tree for early HREFs
      ARM: ux500: Add support for gpio-keys and Proximity Sensor for HREF
      ARM: ux500: Remove platform specific device registration when DT is enabled
      ARM: ux500: Move all Device Tree booting into cpu-db8500
      ARM: ux500: Strip out duplicate touch screen platform information
      Documentation: Detail permitted DT properties for the BU21013 Touch Screen
      ARM: ux500: Create a new Device Tree include file for boards supporting STUIBs
      ARM: ux500: Stop calling the UIB init function when using Device Tree
      ARM: ux500: Add all bu21013 touch screen components to supported Device Trees
      ARM: ux500: Stop informing the regulator subsystem that we have full constraints
      ARM: ux500: Apply a Device Tree node for the STMPE MFD
      ARM: ux500: Supply the STMPE keypad Device Tree node to the STUIB DT
      ARM: ux500: Remove unused board compatible string
      ARM: ux500: Add skeleton DTS file for the u9540
      ARM: ux500: Add support for ST-Ericsson's u9540 SoC
      ARM: ux500: Add UART support to the u9540 Device Tree
      ARM: ux500: Enable SDI4 port on the u9540 when booting with Device Tree
      ARM: ux500: Enable all MMC devices on the u9540 when booting with DT
      ARM: ux500: Rename references to the ccu9540 dev board accordingly
      ARM: ux500: Remove duplicate DT_MACHINE_START - make u8500 for generic
      ARM: ux500: List DT compatibility using platform names rather than by board
      ARM: ux500: Add node for the MMC GPIO regulator
      ARM: ux500: Change the type of interrupt to something compatible
      ARM: ux500: CONFIG: Enable GPIO Regulators
      ARM: ux500: Convert DT_MACHINE_START to use SMP operations

 .../bindings/input/touchscreen/bu21013.txt         |   28 ++
 arch/arm/boot/dts/ccu9540.dts                      |   72 ++++++
 arch/arm/boot/dts/dbx5x0.dtsi                      |   57 ++--
 arch/arm/boot/dts/href.dtsi                        |  273 ++++++++++++++++++++
 arch/arm/boot/dts/hrefprev60.dts                   |   41 +++
 arch/arm/boot/dts/hrefv60plus.dts                  |   83 +-----
 arch/arm/boot/dts/snowball.dts                     |  140 +++++++++-
 arch/arm/boot/dts/stuib.dtsi                       |   78 ++++++
 arch/arm/configs/u8500_defconfig                   |    1 +
 arch/arm/mach-ux500/board-mop500-stuib.c           |   22 +-
 arch/arm/mach-ux500/board-mop500.c                 |  146 +----------
 arch/arm/mach-ux500/board-mop500.h                 |    8 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |  108 +++++++-
 arch/arm/mach-ux500/cpu.c                          |    3 +
 14 files changed, 779 insertions(+), 281 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
 create mode 100644 arch/arm/boot/dts/ccu9540.dts
 create mode 100644 arch/arm/boot/dts/href.dtsi
 create mode 100644 arch/arm/boot/dts/hrefprev60.dts
 create mode 100644 arch/arm/boot/dts/stuib.dtsi

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
