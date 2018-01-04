From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 4 Jan 2018 15:44:20 +0800
Subject: [PATCH v1 4/6] dt-bindings: clock: mediatek: add "simple-mfd" in
 audsys documentation
In-Reply-To: <cover.1515038387.git.ryder.lee@mediatek.com>
References: <cover.1515038387.git.ryder.lee@mediatek.com>
Message-ID: <bd1cb0aeaf07b4bf2cedbf00ef8fedc6ba01f9cb.1515038387.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "simple-mfd" to support MFD device and add a compatible string for MT2701.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,audsys.txt       | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index 9b8f578..6e97552 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -6,17 +6,25 @@ The MediaTek AUDSYS controller provides various clocks to the system.
 Required Properties:
 
 - compatible: Should be one of:
-	- "mediatek,mt7622-audsys", "syscon"
+	- "mediatek,mt2701-audsys", "syscon", "simple-mfd"
+	- "mediatek,mt7622-audsys", "syscon", "simple-mfd"
 - #clock-cells: Must be 1
 
 The AUDSYS controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
 The available clocks are defined in dt-bindings/clock/mt*-clk.h.
 
+See ../sound/mt2701-afe-pcm.txt for details about required subnode.
+
 Example:
 
-audsys: audsys at 11220000 {
-	compatible = "mediatek,mt7622-audsys", "syscon";
-	reg = <0 0x11220000 0 0x1000>;
-	#clock-cells = <1>;
-};
+	audsys: audio-subsystem at 11220000 {
+		compatible = "mediatek,mt2701-audsys", "syscon", "simple-mfd";
+		reg = <0 0x11220000 0 0x1000>;
+		#clock-cells = <1>;
+
+		afe: audio-controller {
+			compatible = "mediatek,mt2701-audio";
+			...
+		};
+	};
-- 
1.9.1
