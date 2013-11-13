From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 13 Nov 2013 09:31:12 +0800
Subject: [PATCH v11 0/2] Enable clock driver of Hi3620 SoC
Message-ID: <1384306274-27315-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable common clock driver of Hi3620 SoC.

v11:
  1. Abandon original solution on parsing all clock from DTS file. Create
  the clock tree in c code. So clock identifier is added into DTS file.
  2. Avoid to use hi3xxx prefix. Use hisi prefix instead.

Haojian Zhuang (2):
  clk: hisilicon: add common clock support
  ARM: dts: enable clock binding on Hi3620

 .../devicetree/bindings/clock/hi3620-clock.txt     |  19 ++
 arch/arm/boot/dts/hi3620.dtsi                      |  79 ++++---
 arch/arm/boot/dts/hi4511.dts                       |   3 +-
 drivers/clk/Makefile                               |   1 +
 drivers/clk/hisilicon/Makefile                     |   5 +
 drivers/clk/hisilicon/clk-hi3620.c                 | 242 +++++++++++++++++++++
 drivers/clk/hisilicon/clk.c                        | 171 +++++++++++++++
 drivers/clk/hisilicon/clk.h                        | 103 +++++++++
 drivers/clk/hisilicon/clkgate-seperated.c          | 130 +++++++++++
 include/dt-bindings/clock/hi3620-clock.h           | 152 +++++++++++++
 10 files changed, 869 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hi3620-clock.txt
 create mode 100644 drivers/clk/hisilicon/Makefile
 create mode 100644 drivers/clk/hisilicon/clk-hi3620.c
 create mode 100644 drivers/clk/hisilicon/clk.c
 create mode 100644 drivers/clk/hisilicon/clk.h
 create mode 100644 drivers/clk/hisilicon/clkgate-seperated.c
 create mode 100644 include/dt-bindings/clock/hi3620-clock.h

-- 
1.8.3.2
