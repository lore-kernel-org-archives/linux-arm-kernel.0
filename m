From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 21 Feb 2017 14:55:01 +0800
Subject: [PATCH V2 0/3] Add Spreadtrum SP9860G support
Message-ID: <1487660104-15693-1-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SC9860 is a Spreadtrum SoC with eight Cortex A53, which are divided
into 4 Big cores and 4 little cores.

This patch-set only provides a basic configuration for SC9860 in device
tree to make it run to console.  We will continue to submit other drivers
later on, which are using on Spreadtrum's SoCs.

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

Chunyan Zhang (1):
  Documentation: sprd: Add bindings for SP9860G

Orson Zhai (1):
  arm64: dts: Add basic DT to support Spreadtrum's SP9860G

Wei Qiao (1):
  serial: sprd: adjust TIMEOUT to a big value

 Documentation/devicetree/bindings/arm/sprd.txt     |  13 +-
 .../devicetree/bindings/serial/sprd-uart.txt       |  16 +-
 arch/arm64/boot/dts/sprd/Makefile                  |   3 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi               | 531 +++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts          |  56 +++
 arch/arm64/boot/dts/sprd/whale2.dtsi               |  70 +++
 drivers/tty/serial/sprd_serial.c                   |   2 +-
 7 files changed, 683 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/sprd/sc9860.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
 create mode 100644 arch/arm64/boot/dts/sprd/whale2.dtsi

-- 
2.7.4
