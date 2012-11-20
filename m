From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Nov 2012 16:28:36 +0000
Subject: [GIT PULL] ST-Ericsson Device Tree patches
Message-ID: <20121120162836.GE28265@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the previous pull request with a couple of patches appended:

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

  Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ljones/linux-3.0-ux500.git ste-dt-for-next

for you to fetch changes up to cece5c4009355323c6f453ef6814e7dd85a0f896:

  ARM: ux500: Describe UART platform registering issues more accurately (2012-11-20 16:10:47 +0000)

----------------------------------------------------------------
Lee Jones (38):
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
      ARM: ux500: Move regulator-name properties out to board DTS files
      ARM: ux500: Add SDI (MMC) support to the HREF Device Tree
      ARM: ux500: Add skeleton DTS file for the u9540
      ARM: ux500: Add UART support to the u9540 Device Tree
      ARM: ux500: Enable SDI4 port on the u9540 when booting with Device Tree
      ARM: ux500: Enable all MMC devices on the u9540 when booting with DT
      ARM: ux500: Describe UART platform registering issues more accurately

 .../bindings/input/touchscreen/bu21013.txt         |   28 ++
 arch/arm/boot/dts/ccu9540.dts                      |   72 ++++++
 arch/arm/boot/dts/dbx5x0.dtsi                      |   57 ++--
 arch/arm/boot/dts/href.dtsi                        |  273 ++++++++++++++++++++
 arch/arm/boot/dts/hrefprev60.dts                   |   41 +++
 arch/arm/boot/dts/hrefv60plus.dts                  |  217 ++++++++++++----
 arch/arm/boot/dts/snowball.dts                     |  140 +++++++++-
 arch/arm/boot/dts/stuib.dtsi                       |   78 ++++++
 arch/arm/boot/dts/u9540.dts                        |   72 ++++++
 arch/arm/configs/u8500_defconfig                   |    1 +
 arch/arm/mach-ux500/board-mop500-stuib.c           |   22 +-
 arch/arm/mach-ux500/board-mop500.c                 |  146 +----------
 arch/arm/mach-ux500/board-mop500.h                 |    8 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |  107 +++++++-
 arch/arm/mach-ux500/cpu.c                          |    3 +
 15 files changed, 1005 insertions(+), 260 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
 create mode 100644 arch/arm/boot/dts/ccu9540.dts
 create mode 100644 arch/arm/boot/dts/href.dtsi
 create mode 100644 arch/arm/boot/dts/hrefprev60.dts
 create mode 100644 arch/arm/boot/dts/stuib.dtsi
 create mode 100644 arch/arm/boot/dts/u9540.dts

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
