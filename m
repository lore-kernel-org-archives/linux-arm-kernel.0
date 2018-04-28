From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sat, 28 Apr 2018 10:21:09 +0000
Subject: [PATCH v2 0/2] net: stmmac: dwmac-meson: 100M phy mode support for
 AXG SoC
Message-ID: <20180428102111.18384-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the dwmac glue layer register changed, we need to 
introduce a new compatible name for the Meson-AXG SoC
to support for the RMII 100M ethernet PHY.

Change since v1 at [1]:
  - implement set_phy_mode() for each SoC

[1] https://lkml.kernel.org/r/20180426160508.29380-1-yixun.lan at amlogic.com

Yixun Lan (2):
  dt-bindings: net: meson-dwmac: new compatible name for AXG SoC
  net: stmmac: dwmac-meson: extend phy mode setting

 .../devicetree/bindings/net/meson-dwmac.txt   |   1 +
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 120 +++++++++++++++---
 2 files changed, 105 insertions(+), 16 deletions(-)

-- 
2.17.0
