From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 7 Oct 2015 17:14:39 +0800
Subject: [PATCH v2 1/3] dt-bindings: soc: Add clocks for Mediatek SCPSYS unit
In-Reply-To: <1444209281-25536-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1444209281-25536-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1444209281-25536-2-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clocks needed by Mediatek VENC and VENC_LT power domianis.
These clocks were needed by accessing subsystem's registers,
so they need to be enabled before power on these subsystems.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index c051114..a6c8afc 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -17,9 +17,9 @@ Required properties:
 - reg: Address range of the SCPSYS unit
 - infracfg: must contain a phandle to the infracfg controller
 - clock, clock-names: clocks according to the common clock binding.
-                      The clocks needed "mm" and "mfg". These are the
-		      clocks which hardware needs to be enabled before
-		      enabling certain power domains.
+                      The clocks needed "mm", "mfg", "venc" and "venc_lt".
+		      These are the clocks which hardware needs to be enabled
+		      before enabling certain power domains.
 
 Example:
 
@@ -30,7 +30,9 @@ Example:
 		infracfg = <&infracfg>;
 		clocks = <&clk26m>,
 			 <&topckgen CLK_TOP_MM_SEL>;
-		clock-names = "mfg", "mm";
+			 <&topckgen CLK_TOP_VENC_SEL>,
+			 <&topckgen CLK_TOP_VENC_LT_SEL>;
+		clock-names = "mfg", "mm", "venc", "venc_lt";
 	};
 
 Example consumer:
-- 
1.9.1
