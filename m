From: henryc.chen@mediatek.com (Henry Chen)
Date: Fri, 30 Jan 2015 13:13:11 +0800
Subject: [PATCH v4 0/7] clk: Add common clock support for Mediatek MT8135 and
 MT8173.
Message-ID: <1422594798-13375-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial common clock support for Mediatek SoCs.
Mediatek SoC's clock architecture comprises of various PLLs, dividers, muxes and clock gates.

This patchset also contains a basic clock support for Mediatek MT8135 and MT8173.

This driver is based on 3.19-rc1 + MT8135 and MT8173 basic support.

Changes in v2:
- Re-ordered patchset. Fold include/dt-bindings and DT document in 1st patch.

Changes in v3:
- Rebase to 3.19-rc1.
- Refine code. Remove unneed functions, debug logs and comments, and fine tune error logs.

Changes in v4:
- Support MT8173 platform.
- Re-ordered patchset. driver/clk/Makefile in 2nd patch.
- Extract the common part definition(mtk_gate/mtk_pll/mtk_mux) from clk-mt8135.c/clk-mt8173.c to clk-mtk.c.
- Refine code. Rmove unnessacary debug information and unsed defines, add prefix "mtk_" for static functions.
- Remove flag CLK_IGNORE_UNUSED and set flag CLK_SET_RATE_PARENT on gate/mux/fixed-factor.
- Use spin_lock_irqsave(&clk_ops_lock, flags) instead of mtk_clk_lock.
- Example above include a node for the clock controller itself, followed by the i2c controller example above.

James Liao (7):
  clk: dts: mediatek: add Mediatek MT8135 clock bindings
  clk: mediatek: Add initial common clock support for Mediatek SoCs.
  clk: mediatek: Add basic clocks for Mediatek MT8135.
  dts: mediatek: Enable clock support for Mediatek MT8135.
  clk: dts: mediatek: add Mediatek MT8173 clock bindings
  clk: mediatek: Add basic clocks for Mediatek MT8173.
  dts: mediatek: Enable clock support for Mediatek MT8173.

 .../bindings/clock/mediatek,mt8135-clock.txt       |   44 +
 .../bindings/clock/mediatek,mt8173-clock.txt       |   42 +
 arch/arm/boot/dts/mt8135.dtsi                      |   47 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   46 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/mediatek/Makefile                      |    3 +
 drivers/clk/mediatek/clk-gate.c                    |  140 +++
 drivers/clk/mediatek/clk-gate.h                    |   49 +
 drivers/clk/mediatek/clk-mt8135-pll.c              |  860 ++++++++++++++++
 drivers/clk/mediatek/clk-mt8135-pll.h              |   28 +
 drivers/clk/mediatek/clk-mt8135.c                  |  866 +++++++++++++++++
 drivers/clk/mediatek/clk-mt8173-pll.c              |  807 +++++++++++++++
 drivers/clk/mediatek/clk-mt8173-pll.h              |   14 +
 drivers/clk/mediatek/clk-mt8173.c                  | 1028 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                     |  154 +++
 drivers/clk/mediatek/clk-mtk.h                     |  132 +++
 drivers/clk/mediatek/clk-pll.c                     |   63 ++
 drivers/clk/mediatek/clk-pll.h                     |   52 +
 include/dt-bindings/clock/mt8135-clk.h             |  190 ++++
 include/dt-bindings/clock/mt8173-clk.h             |  214 ++++
 20 files changed, 4780 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8135-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8173-clock.txt
 create mode 100644 drivers/clk/mediatek/Makefile
 create mode 100644 drivers/clk/mediatek/clk-gate.c
 create mode 100644 drivers/clk/mediatek/clk-gate.h
 create mode 100644 drivers/clk/mediatek/clk-mt8135-pll.c
 create mode 100644 drivers/clk/mediatek/clk-mt8135-pll.h
 create mode 100644 drivers/clk/mediatek/clk-mt8135.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-pll.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-pll.h
 create mode 100644 drivers/clk/mediatek/clk-mt8173.c
 create mode 100644 drivers/clk/mediatek/clk-mtk.c
 create mode 100644 drivers/clk/mediatek/clk-mtk.h
 create mode 100644 drivers/clk/mediatek/clk-pll.c
 create mode 100644 drivers/clk/mediatek/clk-pll.h
 create mode 100644 include/dt-bindings/clock/mt8135-clk.h
 create mode 100644 include/dt-bindings/clock/mt8173-clk.h

-- 
1.8.1.1.dirty
