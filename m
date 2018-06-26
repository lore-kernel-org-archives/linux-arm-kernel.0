From: sravanhome@gmail.com (Saravanan Sekar)
Date: Tue, 26 Jun 2018 21:28:18 +0200
Subject: [PATCH 0/2] Add clock driver for Actions S700 SoC 
Message-ID: <20180626192820.28237-1-sravanhome@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds clock support for Actions Semi OWL series
S700 SoC with relevant clock bindings and device tree info.

Changed the UART clock using CMU instance and changes are
tested in cubieboard7 

Thanks and regards,
Saravanan,
Parthiban

Saravanan Sekar (2):
  arm64: dts: actions: Enable clock controller for S700
  clk: actions: Add S700 SoC clock support

 .../boot/dts/actions/s700-cubieboard7.dts     |   7 -
 arch/arm64/boot/dts/actions/s700.dtsi         |   8 +
 drivers/clk/actions/Kconfig                   |   7 +
 drivers/clk/actions/Makefile                  |   1 +
 drivers/clk/actions/owl-s700.c                | 614 ++++++++++++++++++
 include/dt-bindings/clock/actions,s700-cmu.h  | 128 ++++
 6 files changed, 758 insertions(+), 7 deletions(-)
 create mode 100644 drivers/clk/actions/owl-s700.c
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

-- 
2.18.0
