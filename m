From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue,  7 Nov 2017 01:15:49 +0530
Subject: [PATCH v2 0/3] Add clock driver for Actions S900 SoC
Message-ID: <1509997552-29718-1-git-send-email-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds clock driver for Actions Semi OWL series
S900 SoC with relevant clock bindings and device tree data.

This series also addresses the review comments from previous
submission happened last year.

https://patchwork.kernel.org/patch/9254471/

Driver has been validated on Bubblegum-96 board.

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: clock: Add Actions S900 clock bindings
  arm64: dts: actions: Add S900 clock management unit nodes
  clk: actions: Add clock driver for Actions S900 SoC

 .../devicetree/bindings/clock/actions,s900-cmu.txt |  47 ++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/actions/s900.dtsi              |  20 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/actions/Kconfig                        |   6 +
 drivers/clk/actions/Makefile                       |   2 +
 drivers/clk/actions/owl-clk.c                      | 316 +++++++++++
 drivers/clk/actions/owl-clk.h                      | 298 +++++++++++
 drivers/clk/actions/owl-factor.c                   | 268 ++++++++++
 drivers/clk/actions/owl-pll.c                      | 344 ++++++++++++
 drivers/clk/actions/owl-s900.c                     | 585 +++++++++++++++++++++
 include/dt-bindings/clock/actions,s900-cmu.h       | 139 +++++
 13 files changed, 2035 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
 create mode 100644 drivers/clk/actions/Kconfig
 create mode 100644 drivers/clk/actions/Makefile
 create mode 100644 drivers/clk/actions/owl-clk.c
 create mode 100644 drivers/clk/actions/owl-clk.h
 create mode 100644 drivers/clk/actions/owl-factor.c
 create mode 100644 drivers/clk/actions/owl-pll.c
 create mode 100644 drivers/clk/actions/owl-s900.c
 create mode 100644 include/dt-bindings/clock/actions,s900-cmu.h

-- 
2.7.4
