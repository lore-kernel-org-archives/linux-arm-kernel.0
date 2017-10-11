From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Wed, 11 Oct 2017 10:41:24 +0800
Subject: [PATCH v5 00/13] mmc: mediatek: add support of mt2701/mt2712
Message-ID: <1507689696-25928-1-git-send-email-chaotian.jing@mediatek.com>
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
add a "mediatek,latch-ck" to work-around as it do not support stop-clk fix.

Note: As Pinctrl/CCF are not ready now, so that current patches do not
include DTS part.

Changed vs v4:
  based on Julien's comment, change the "bool pad_tune0" to "u32 pad_tune_reg".

Changed vs v3:
  based on Ulf's comments, make the bindings change to be the first patch.

Changed vs v2:
  based on Matthias's comments, merge binding file changes to one patch,
add "hs400_tune" flag in dev_comp.

Changed vs v1:
  based on Ulf/Rob/Matthias's comments of DTS binding file, make the binding
file clearly and fix probe issue.


Chaotian Jing (12):
  mmc: dt-bindings: Add reg/source_cg/latch-ck for Mediatek MMC bindings
  mmc: mediatek: add support of mt2701/mt2712
  arm64: dts: mt8173: remove "mediatek,mt8135-mmc" from mmc nodes
  mmc: mediatek: make hs400_tune_response only for mt8173
  mmc: mediatek: add pad_tune0 support
  mmc: mediatek: add async fifo and data tune support
  mmc: mediatek: add busy_check support
  mmc: mediatek: add stop_clk fix and enhance_rx support
  mmc: mediatek: add support of source_cg clock
  mmc: mediatek: add latch-ck support
  mmc: mediatek: improve eMMC hs400 mode read performance
  mmc: mediatek: perfer to use rise edge latching for cmd line

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |  16 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |  12 +-
 drivers/mmc/host/mtk-sd.c                        | 283 ++++++++++++++++++++---
 3 files changed, 263 insertions(+), 48 deletions(-)

-- 
1.8.1.1.dirty
