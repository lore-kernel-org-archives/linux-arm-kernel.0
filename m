From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 7 Jan 2015 11:25:19 +0800
Subject: [PATCH v3 0/4] clk: mediatek: Add common clock support for Mediatek
 MT8135.
Message-ID: <1420601123-25859-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial common clock support for Mediatek SoCs.
Mediatek SoC's clock architecture comprises of various PLLs, dividers,
muxes and clock gates.

This patchset also contains a basic clock support for Mediatek MT8135.

This driver is based on 3.19-rc1 + MT8135 basic support.

Changes in v2:
- Re-ordered patchset. Fold include/dt-bindings and DT document in 1st
patch.

Changes in v3:
- Rebase to 3.19-rc1.
- Refine code. Remove unneed functions, debug logs and comments, and fine tune
error logs.

James Liao (4):
  clk: dts: mediatek: add Mediatek MT8135 clock bindings
  clk: mediatek: Add initial common clock support for Mediatek SoCs.
  clk: mediatek: Add basic clocks for Mediatek MT8135.
  dts: mediatek: Enable clock support for Mediatek MT8135.

 .../bindings/clock/mediatek,mt8135-clock.txt       |  36 +
 arch/arm/boot/dts/mt8135.dtsi                      |  47 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/mediatek/Makefile                      |   2 +
 drivers/clk/mediatek/clk-gate.c                    | 150 ++++
 drivers/clk/mediatek/clk-gate.h                    |  48 +
 drivers/clk/mediatek/clk-mt8135-pll.c              | 902 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt8135-pll.h              |  28 +
 drivers/clk/mediatek/clk-mt8135.c                  | 974 +++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                     |  89 ++
 drivers/clk/mediatek/clk-mtk.h                     |  47 +
 drivers/clk/mediatek/clk-pll.c                     |  59 ++
 drivers/clk/mediatek/clk-pll.h                     |  50 ++
 include/dt-bindings/clock/mt8135-clk.h             | 190 ++++
 14 files changed, 2623 insertions(+)
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
