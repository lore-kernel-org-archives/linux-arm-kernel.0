From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  1 Nov 2017 01:24:20 +0530
Subject: [PATCH 0/3] Add clock driver for Actions S900 SoC
Message-ID: <1509479663-8985-1-git-send-email-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds clock driver for Actions Semi OWL series
S900 SoC with relevant clock bindings and device tree data.

This series also addresses the review comments from previous
submission happened last year.

https://patchwork.kernel.org/patch/9254471/

Driver has been validated on Bubblegum-96 board.

Thanks,
Mani

Manivannan Sadhasivam (3):
  arm64: dts: actions: add s900 clock controller nodes
  clk: owl: add clock driver for Actions S900 SoC
  Documentation: add Actions S900 clock bindings

 .../bindings/clock/actions,s900-clock.txt          |  47 ++
 MAINTAINERS                                        |   5 +
 arch/arm64/boot/dts/actions/s900.dtsi              |  19 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/owl/Makefile                           |   2 +
 drivers/clk/owl/clk-factor.c                       | 270 ++++++++++
 drivers/clk/owl/clk-pll.c                          | 346 ++++++++++++
 drivers/clk/owl/clk-s900.c                         | 587 +++++++++++++++++++++
 drivers/clk/owl/clk.c                              | 318 +++++++++++
 drivers/clk/owl/clk.h                              | 301 +++++++++++
 include/dt-bindings/clock/actions,s900-clock.h     | 141 +++++
 11 files changed, 2037 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/actions,s900-clock.txt
 create mode 100644 drivers/clk/owl/Makefile
 create mode 100644 drivers/clk/owl/clk-factor.c
 create mode 100644 drivers/clk/owl/clk-pll.c
 create mode 100644 drivers/clk/owl/clk-s900.c
 create mode 100644 drivers/clk/owl/clk.c
 create mode 100644 drivers/clk/owl/clk.h
 create mode 100644 include/dt-bindings/clock/actions,s900-clock.h

-- 
2.7.4
