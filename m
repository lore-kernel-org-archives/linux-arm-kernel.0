From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Fri, 4 Aug 2017 09:32:27 +0800
Subject: [PATCH v3 3/4] dt-bindings: mediatek: add descriptions for larbid
In-Reply-To: <1501810348-20997-1-git-send-email-honghui.zhang@mediatek.com>
References: <1501810348-20997-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1501810348-20997-4-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

This patch add larbid descritptions for mediatek's gen1 smi larb hardware.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 .../bindings/memory-controllers/mediatek,smi-larb.txt     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
index 21277a5..ddf46b8 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
@@ -15,6 +15,9 @@ Required properties:
 	    the register.
   - "smi" : It's the clock for transfer data and command.
 
+Required property for mt2701:
+- mediatek,larb-id :the hardware id of this larb.
+
 Example:
 	larb1: larb at 16010000 {
 		compatible = "mediatek,mt8173-smi-larb";
@@ -25,3 +28,15 @@ Example:
 			 <&vdecsys CLK_VDEC_LARB_CKEN>;
 		clock-names = "apb", "smi";
 	};
+
+Example for mt2701:
+	larb0: larb at 14010000 {
+		compatible = "mediatek,mt2701-smi-larb";
+		reg = <0 0x14010000 0 0x1000>;
+		mediatek,smi = <&smi_common>;
+		mediatek,larb-id = <0>;
+		clocks = <&mmsys CLK_MM_SMI_LARB0>,
+			 <&mmsys CLK_MM_SMI_LARB0>;
+		clock-names = "apb", "smi";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
+	};
-- 
2.6.4
