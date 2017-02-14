From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 14 Feb 2017 17:19:07 +0800
Subject: [PATCH 0/5] Add Spreadtrum SP9860G support
Message-ID: <1487063952-7113-1-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SC9860 is a Spreadtrum SoC with eight Cortex A53, which are divided
into 4 Big cores and 4 little cores.

In this patch-set, patch-1/5 only provides a basic configuration for SC9860
in device tree to make it run to console.  After this we will continue
to submit other drivers step by step, which are using on Spreadtrum's SoCs.

This patch-set also adjusted the compatible string of sprd_serial from
'sc9836-uart' to 'sc-uart', because this serial driver is not only for
SC9836 but for all Spreadtrum SoCs so far.

Thanks,
Chunyan

Chunyan Zhang (3):
  Documentation: sprd: Add bindings for SP9860G
  devicetree: bindings: revise compatible string of sprd uart
  sprd_serial: switch comptible string to sc-uart

Orson Zhai (1):
  arm64: dts: Add basic DT to support Spreadtrum's SP9860G

Wei Qiao (1):
  serial: sprd: adjust TIMEOUT to a big value

 Documentation/devicetree/bindings/arm/sprd.txt     |  13 +-
 .../devicetree/bindings/serial/sprd-uart.txt       |   2 +-
 arch/arm64/boot/dts/sprd/Makefile                  |   3 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi               | 534 +++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts          |  58 +++
 arch/arm64/boot/dts/sprd/whale2.dtsi               |  66 +++
 drivers/tty/serial/sprd_serial.c                   |   6 +-
 7 files changed, 672 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/sprd/sc9860.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
 create mode 100644 arch/arm64/boot/dts/sprd/whale2.dtsi

-- 
2.7.4
