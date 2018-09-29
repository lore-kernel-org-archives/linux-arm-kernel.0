From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Sat, 29 Sep 2018 10:29:54 +0800
Subject: [PATCH v1 1/2] mmc: dt-bindings: add "bus-clk" for MT2712
Message-ID: <1538188195-3608-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On MT2712 MSDC0/3, HCLK/bus-clk need gate/ungate together,
or will hang when access MSDC register.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index f33467a..f2208f4 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -22,6 +22,7 @@ Required properties:
 	"source" - source clock (required)
 	"hclk" - HCLK which used for host (required)
 	"source_cg" - independent source clock gate (required for MT2712)
+	"bus_clk" - bus clock used for internal register access (required for MT2712 MSDC0/3)
 - pinctrl-names: should be "default", "state_uhs"
 - pinctrl-0: should contain default/high speed pin ctrl
 - pinctrl-1: should contain uhs mode pin ctrl
-- 
1.8.1.1.dirty
