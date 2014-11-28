From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 28 Nov 2014 19:34:46 +0800
Subject: [PATCH 0/4] Add common clock support for Mediatek MT8135. 
Message-ID: <1417174490-6845-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial common clock support for Mediatek SoCs.
Mediatek SoC's clock architecture comprises of various PLLs, dividers, 
muxes and clock gates.

This patchset also contains a basic clock support for Mediatek MT8135.

This driver is based on 3.18-rc1 + MT8135 basic support.

James Liao (4):
  clk: Add initial common clock support for Mediatek SoC MT8135.
  clk: Add INFRA and PERI clocks for Mediatek MT8135.
  clk: dts: document Mediatek MT8135 clock binding
  dts: Enable clock support for Mediatek MT8135.

 .../bindings/clock/mediatek,mt8135-clock.txt       |   36 +
 arch/arm/boot/dts/mt8135.dtsi                      |   47 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/mediatek/Makefile                      |    2 +
 drivers/clk/mediatek/clk-gate.c                    |  151 +++
 drivers/clk/mediatek/clk-gate.h                    |   48 +
 drivers/clk/mediatek/clk-mt8135-pll.c              |  891 +++++++++++++++++
 drivers/clk/mediatek/clk-mt8135-pll.h              |   28 +
 drivers/clk/mediatek/clk-mt8135.c                  | 1012 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                     |   93 ++
 drivers/clk/mediatek/clk-mtk.h                     |   47 +
 drivers/clk/mediatek/clk-pll.c                     |   63 ++
 drivers/clk/mediatek/clk-pll.h                     |   50 +
 include/dt-bindings/clock/mt8135-clk.h             |  190 ++++
 14 files changed, 2659 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8135-clock.txt
 create mode 100644 drivers/clk/mediatek/Makefile
 create mode 100644 drivers/clk/mediatek/clk-gate.c
 create mode 100644 drivers/clk/mediatek/clk-gate.h
 create mode 100644 drivers/clk/mediatek/clk-mt8135-pll.c
 create mode 100644 drivers/clk/mediatek/clk-mt8135-pll.h
 create mode 100644 drivers/clk/mediatek/clk-mt8135.c
 create mode 100644 drivers/clk/mediatek/clk-mtk.c
 create mode 100644 drivers/clk/mediatek/clk-mtk.h
 create mode 100644 drivers/clk/mediatek/clk-pll.c
 create mode 100644 drivers/clk/mediatek/clk-pll.h
 create mode 100644 include/dt-bindings/clock/mt8135-clk.h

--
1.8.1.1.dirty
