From: wenpan@hisilicon.com (Pan Wen)
Date: Mon, 17 Oct 2016 20:07:02 +0800
Subject: [PATCH 0/3] add basic SoC support for HiSilicon Hi3516CV300
Message-ID: <20161017120705.3726-1-wenpan@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi3516CV300 is a SoC designed for HD IP camera. It has an integrated ISP and
H.265 video compression encoder. This patch set is mainly used to add basic SoC
support for Hi3516CV300. It includes crg driver and basic dts files.

Pan Wen (3):
  arm: hisi: add ARCH_MULTI_V5 support
  clk: hisilicon: add CRG driver for Hi3516CV300 SoC
  dts: hisi: add dts files for Hi3516CV300 demo board

 .../devicetree/bindings/clock/hisi-crg.txt         |  50 +++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/hi3516cv300-demb.dts             | 148 ++++++++
 arch/arm/boot/dts/hi3516cv300.dtsi                 | 397 +++++++++++++++++++++
 arch/arm/mach-hisi/Kconfig                         |  10 +-
 drivers/clk/hisilicon/Kconfig                      |   8 +
 drivers/clk/hisilicon/Makefile                     |   1 +
 drivers/clk/hisilicon/crg-hi3516cv300.c            | 330 +++++++++++++++++
 drivers/clk/hisilicon/crg.h                        |  34 ++
 include/dt-bindings/clock/hi3516cv300-clock.h      |  48 +++
 10 files changed, 1021 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hisi-crg.txt
 create mode 100644 arch/arm/boot/dts/hi3516cv300-demb.dts
 create mode 100644 arch/arm/boot/dts/hi3516cv300.dtsi
 create mode 100644 drivers/clk/hisilicon/crg-hi3516cv300.c
 create mode 100644 drivers/clk/hisilicon/crg.h
 create mode 100644 include/dt-bindings/clock/hi3516cv300-clock.h

-- 
2.9.3
