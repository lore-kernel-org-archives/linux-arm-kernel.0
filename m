From: vabhav.sharma@nxp.com (Vabhav Sharma)
Date: Thu, 25 Oct 2018 07:01:28 +0000
Subject: [PATCH v6 0/6] arm64: dts: NXP: add basic dts file for LX2160A SoC
Message-ID: <1540407376-24115-1-git-send-email-vabhav.sharma@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes for v6:
- Added comment for clock unit-sysclk node name in SoC device tree 

Changes for v5:
- Updated temperature sensor regulator name in board device tree
- Sorted nodes alphabatically and unit-address in SoC/board device tree
- Identation, new line update in SoC/board device tree
- Updated nodes name as per DT spec generic name recommendation in SoC DT
- Updated macro define for interrupt/gpio property
- Updated i2c node property name scl-gpio
- Removed device_type property except cpu/memory node
- Added esdhc controller nodes in SoC/RDB board device tree
- Added aliases for uart/crypto nodes
- Add SoC die attribute definition for LX2160A

Changes for v4:
- Updated bindings for lx2160a clockgen and dcfg
- Modified commit message for lx2160a clockgen changes
- Updated interrupt property with macro definition
- Added required enable-method property to each core node with psci value
- Removed unused node syscon in device tree
- Removed blank lines in device tree fsl-lx2160a.dtsi
- Updated uart node compatible sbsa-uart first
- Added and defined vcc-supply property to temperature sensor node in
  device tree fsl-lx2160a-rdb.dts

Changes for v3:
-Split clockgen support patch into below two patches:
- a)Updated array size of cmux_to_group[] with NUM_CMUX+1 to include -1
 terminator and p4080 cmux_to_group[] array with -1 terminator
- b)Add clockgen support for lx2160a

Changes for v2:
- Modified cmux_to_group array to include -1 terminator
- Revert NUM_CMUX to original value 8 from 16
- Remove ? LX2160A is 16 core, so modified value for NUM_CMUXX
  in patch "[PATCH 3/5] drivers: clk-qoriq: Add clockgen support for
  lx2160a" description
- Populated cache properties for L1 and L2 cache in lx2160a device-tree.
- Removed reboot node from lx2160a device-tree as PSCI is implemented.
- Removed incorrect comment for timer node interrupt property in
  lx2160a device-tree.
- Modified pmu node compatible property from "arm,armv8-pmuv3" to
  "arm,cortex-a72-pmu" in lx2160a device-tree
- Non-standard aliases removed in lx2160a rdb board device-tree
- Updated i2c child nodes to generic name in lx2160a rdb device-tree.

Changes for v1:
- Add compatible string for LX2160A clockgen support
- Add compatible string to initialize LX2160A guts driver
- Add compatible string for LX2160A support in dt-bindings
- Add dts file to enable support for LX2160A SoC and LX2160A RDB
  (Reference design board)

Vabhav Sharma (4):
  dt-bindings: arm64: add compatible for LX2160A
  soc/fsl/guts: Add definition for LX2160A
  arm64: dts: add QorIQ LX2160A SoC support
  arm64: dts: add LX2160ARDB board support

Yogesh Gaur (2):
  clk: qoriq: increase array size of cmux_to_group
  clk: qoriq: Add clockgen support for lx2160a

 Documentation/devicetree/bindings/arm/fsl.txt      |  14 +-
 .../devicetree/bindings/clock/qoriq-clock.txt      |   1 +
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  | 119 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 766 +++++++++++++++++++++
 drivers/clk/clk-qoriq.c                            |  16 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |   1 +
 drivers/soc/fsl/guts.c                             |   6 +
 8 files changed, 921 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

-- 
2.7.4
