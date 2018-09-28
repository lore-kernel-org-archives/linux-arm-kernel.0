From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Fri, 28 Sep 2018 19:40:54 +0800
Subject: [PATCH 1/2] mmc: dt-bindings: add "bus-clk" for MT2712
In-Reply-To: <1538134855-11198-1-git-send-email-chaotian.jing@mediatek.com>
References: <1538134855-11198-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1538134855-11198-2-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On MT2712 MSDC0/3, HCLK/bus-clk need gate/ungate together,
or will hang when access MSDC register.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index f33467a..182299b 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -22,6 +22,7 @@ Required properties:
 	"source" - source clock (required)
 	"hclk" - HCLK which used for host (required)
 	"source_cg" - independent source clock gate (required for MT2712)
+	"bus_clk" - bus clk used for internal register access(required for MT2712 MSDC0/3)
 - pinctrl-names: should be "default", "state_uhs"
 - pinctrl-0: should contain default/high speed pin ctrl
 - pinctrl-1: should contain uhs mode pin ctrl
-- 
1.8.1.1.dirty
