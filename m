From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 26 Nov 2012 16:07:55 +0000
Subject: [GIT PULL] ST-Ericsson Device Tree patches
In-Reply-To: <20121120162836.GE28265@gmail.com>
References: <20121120162836.GE28265@gmail.com>
Message-ID: <20121126160755.GD6824@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

The previous pull request had some duplicate patches in, which have now been
removed. Please remove the previous branch and replace it with this one.

Kind regards,
Lee

-------------------------------------------------------------------------

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

  Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ljones/linux-3.0-ux500.git ste-dt-for-next

for you to fetch changes up to ad4281e33c0e8420eb53bc8966e14a726af63e3e:

  ARM: dts: add missing ux500 device trees (2012-11-26 15:49:02 +0000)

----------------------------------------------------------------
Fabio Baltieri (1):
      ARM: dts: add missing ux500 device trees

Lee Jones (35):
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
      ARM: ux500: Describe UART platform registering issues more accurately
      ARM: ux500: Disable the MMCI gpio-regulator by default
      ARM: ux500: Move board specific GPIO info out to subordinate DTS files
      ARM: ux500: Stop registering the PCM driver from platform code

 .../bindings/input/touchscreen/bu21013.txt         |   28 ++
 arch/arm/boot/dts/Makefile                         |    5 +-
 arch/arm/boot/dts/ccu9540.dts                      |   72 ++++++
 arch/arm/boot/dts/dbx5x0.dtsi                      |   57 ++--
 arch/arm/boot/dts/href.dtsi                        |  273 ++++++++++++++++++++
 arch/arm/boot/dts/hrefprev60.dts                   |   48 ++++
 arch/arm/boot/dts/hrefv60plus.dts                  |   83 +-----
 arch/arm/boot/dts/snowball.dts                     |  140 +++++++++-
 arch/arm/boot/dts/stuib.dtsi                       |   78 ++++++
 arch/arm/configs/u8500_defconfig                   |    1 +
 arch/arm/mach-ux500/board-mop500-audio.c           |   16 --
 arch/arm/mach-ux500/board-mop500-stuib.c           |   22 +-
 arch/arm/mach-ux500/board-mop500.c                 |  146 +----------
 arch/arm/mach-ux500/board-mop500.h                 |   10 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |  107 +++++++-
 arch/arm/mach-ux500/cpu.c                          |    3 +
 16 files changed, 789 insertions(+), 300 deletions(-)
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
