From: sravanhome@gmail.com (Saravanan Sekar)
Date: Thu, 28 Jun 2018 21:18:02 +0200
Subject: [PATCH v2 0/3] Add clock driver for Actions S700 SoC 
In-Reply-To: <20180626192820.28237-3-sravanhome@gmail.com>
References: <20180626192820.28237-3-sravanhome@gmail.com>
Message-ID: <20180628191805.3722-1-sravanhome@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog v2:
Fixed 0 day compilation warning
Modified existing dts Actions S900 clock bindings common to Actions
Soc family

This patchset adds clock support for Actions Semi OWL series S700 SoC
with relevant clock bindings and device tree info. 

Changed the UART clock using CMU instance and changes are tested in
cubieboard7

Thanks and regards,
Saravanan,
Parthiban

Saravanan Sekar (3):
  arm64: dts: actions: Enable clock controller for S700
  clk: actions: Add S700 SoC clock support
  dt-bindings: clock: Modify Actions Soc clock bindings

 ...ions,s900-cmu.txt => actions,sx00-cmu.txt} |  18 +-
 .../boot/dts/actions/s700-cubieboard7.dts     |   7 -
 arch/arm64/boot/dts/actions/s700.dtsi         |   8 +
 drivers/clk/actions/Kconfig                   |   7 +
 drivers/clk/actions/Makefile                  |   1 +
 drivers/clk/actions/owl-s700.c                | 614 ++++++++++++++++++
 include/dt-bindings/clock/actions,s700-cmu.h  | 128 ++++
 7 files changed, 768 insertions(+), 15 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,sx00-cmu.txt} (71%)
 create mode 100644 drivers/clk/actions/owl-s700.c
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

-- 
2.18.0
