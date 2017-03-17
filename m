From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Fri, 17 Mar 2017 13:51:34 +0800
Subject: [PATCH V4 0/4] Add Spreadtrum SP9860G support
Message-ID: <1489729898-774-1-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SC9860 is a Spreadtrum SoC with eight Cortex A53, which are divided
into 4 Big cores and 4 little cores.

This patch-set provides a basic configuration for SC9860 in device tree
to make it run to console.  After this we will continue to submit other
device drivers step by step, which are using on most of Spreadtrum's SoCs.

Changes from v3:
* Rebased v4.11-rc2;
* Added Reviewed-by of Mathieu;
* Addressed Rob's comments:
  - Documented sprd serial competible according to Rob's suggestion
  - Revised serial node name to match its offset;
* Added STM device node in dt.

Changes from v2:
* Addressed comments from Mathieu:
  - Removed CoreSight devices' lables from DT;
  - Added another level of imbrication for ETFs which have more than one port;
* Addressed comments from Rob:
  - Switched to use SPDX-License-Identifier tag instead;
  - Moved the 26m fixed clock node to top level in DT;
  - Splited the patch into two, since they were revising two dt-bindings;
  - Removed redundant space from sprd-usrt.txt;
  - Removed useless property from the sprd_uart example of DT configuration.

Changes from v1:
* Removed useless idle-state node 'deep_sleep' from DT
* Removed useless property 'sc-id' from DT
* Removed 'clock-frequency' property from the node 'timer'
* Added another compatible string '"arm,cortex-a53-pmu"' and property
  'interrupt-affinity' for pmu
* Kept using the existed compatible string of sprd_serial driver, and added
  a new one for sc9860 in DT.

Thanks,
Chunyan

Chunyan Zhang (2):
  dt-bindings: arm: Add bindings for SP9860G
  dt-bindings: serial: add a new compatible string for SC9860

Orson Zhai (1):
  arm64: dts: Add basic DT to support Spreadtrum's SP9860G

Wei Qiao (1):
  serial: sprd: adjust TIMEOUT to a big value

 Documentation/devicetree/bindings/arm/sprd.txt     |  13 +-
 .../devicetree/bindings/serial/sprd-uart.txt       |  14 +-
 arch/arm64/boot/dts/sprd/Makefile                  |   3 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi               | 569 +++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts          |  56 ++
 arch/arm64/boot/dts/sprd/whale2.dtsi               |  71 +++
 drivers/tty/serial/sprd_serial.c                   |   2 +-
 7 files changed, 720 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/sprd/sc9860.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
 create mode 100644 arch/arm64/boot/dts/sprd/whale2.dtsi

-- 
2.7.4
