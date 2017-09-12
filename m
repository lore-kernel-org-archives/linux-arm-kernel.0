From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 12 Sep 2017 17:07:40 +0800
Subject: mmc: mediatek: add support of mt2701/mt2712 
Message-ID: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  This serial of patches are adding support of mt2701/mt2712.
there are many changes and HW improvement between mt8173 and
mt2701/mt2712, below is a list of these changes:
  1. enlarge CLKDIV bits from 8 to 12
  2. remove the PAD_TUNE register and add a new PAD_TUNE0 register
  3. add data sync and async fifo feature
  4. add busy_check feature
  5. add stop_clk fix
  6. add enhance_rx support
  7. add a seperate CG of source clock

mt2712 supports full of these features, mt2701 supports part of it, and
add a "mediatek,latch-ck" to work-around as it do not support stop-clk
fix.

Note: As Pinctrl/CCF are not ready now, so that current patches do not
include DTS part.


Chaotian Jing (12):
  mmc: dt-bindings: update Mediatek MMC bindings
  arm64: dts: mt8173: remove "mediatek,mt8135-mmc" from mmc nodes
  mmc: mediatek: add support of mt2701/mt2712
  mmc: mediatek: make hs400_tune_response only for mt8173
  mmc: mediatek: add pad_tune0 support
  mmc: mediatek: add async fifo and data tune support
  mmc: mediatek: add busy_check support
  mmc: mediatek: add stop_clk fix and enhance_rx support
  mmc: mediatek: add support of source_cg clock
  mmc: mediatek: add latch-ck support
  mmc: mediatek: improve eMMC hs400 mode read performance
  mmc: mediatek: perfer to use rise edge latching for cmd line

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |  13 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |  12 +-
 drivers/mmc/host/mtk-sd.c                        | 298 ++++++++++++++++++++---
 3 files changed, 275 insertions(+), 48 deletions(-)

-- 
1.9.1
