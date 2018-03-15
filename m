From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Mar 2018 19:36:39 +0800
Subject: [GIT PULL 5/6] Freescale arm64 device tree updates for 4.17
In-Reply-To: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1521113800-16401-5-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.17

for you to fetch changes up to 4e017f1419397473cf3db6e9fa020013998b1aa4:

  dt-bindings: ifc: Fix the unit address format in the examples (2018-03-12 15:38:49 +0800)

----------------------------------------------------------------
Freescale arm64 device tree updates for 4.17:
 - Move cpu_thermal device out of bus node to fix DTC simple_bus_reg
   warning seen with W=1 switch.
 - Fix IFC child nodes' unit-address to eliminate DTC simple_bus_reg
   warnings.
 - Add a dummy size memory 'reg' property for LS1046A device tree to
   avoid unit_address_vs_reg DTC warning, and the real size will be
   filled by bootloader.
 - Update ls208xa-qds board device tree to fix unit_address_vs_reg
   warnings with DSPI device.
 - Add idle-states for LS1012A and LS1043A, and correct
   arm,psci-suspend-param setting for already added idle-states.
 - DPAA QBMan portal and watchdog device addition.

----------------------------------------------------------------
Fabio Estevam (8):
      arm64: dts: ls1012a: Move cpu_thermal out of bus node
      arm64: dts: ls1043a: Move cpu_thermal out of bus node
      arm64: dts: ls1046a: Move cpu_thermal out of bus node
      arm64: dts: ls1088a: Move cpu_thermal out of bus node
      arm64: dts: ls208xa: Move cpu_thermal out of bus node
      arm64: dts: ls208xa-qds: Pass unit name to dspi child nodes
      arm64: dts: ls208xa-qds: Fix the 'reg' property
      dt-bindings: ifc: Fix the unit address format in the examples

Roy Pledge (1):
      arm64: dts: Add DPAA QBMan portal 9

Shawn Guo (2):
      arm64: dts: fsl: fix ifc simple-bus unit address format warnings
      arm64: dts: ls1046a: add a dummy memory 'reg' property

Yuantian Tang (3):
      arm64: dts: ls1012a: add cpu idle support
      arm64: dts: ls1043a: add cpu idle support
      arm64: dts: fsl: update the cpu idle node

Zhang Ying-22455 (1):
      arm64: dts: ls1088a: add DT node of watchdog

 .../bindings/memory-controllers/fsl/ifc.txt        |   6 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  80 +++++++-----
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |   6 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |   6 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  83 ++++++++-----
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |   6 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  |   4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  66 +++++-----
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  |   6 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  |   4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 134 +++++++++++++++------
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi |  14 +--
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |  98 +++++++--------
 .../boot/dts/freescale/qoriq-bman-portals.dtsi     |   6 +
 .../boot/dts/freescale/qoriq-qman-portals.dtsi     |   7 ++
 16 files changed, 319 insertions(+), 209 deletions(-)
