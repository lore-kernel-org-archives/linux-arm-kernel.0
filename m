From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 6 Mar 2018 17:09:29 +0800
Subject: [PATCH v4 4/6] dt-bindings: clock: mediatek: update audsys
 documentation to adapt MFD device
In-Reply-To: <cover.1520327262.git.ryder.lee@mediatek.com>
References: <cover.1520327262.git.ryder.lee@mediatek.com>
Message-ID: <ad47a5c633fea2f75720dcd4b24fa6c41592d38b.1520327262.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MediaTek audio hardware block that exposes functionalities that are
handled by separate subsystems in the kernel.  These functions are all
mapped somewhere at 0x112xxxxx, and there are some control bits are mixed
up with other functions within the same registers.

This patch modifies example to illustrate child nodes.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,audsys.txt         | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index 9b8f578..97b304e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -13,10 +13,19 @@ The AUDSYS controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
 The available clocks are defined in dt-bindings/clock/mt*-clk.h.
 
+Required sub-nodes:
+-------
+For common binding part and usage, refer to
+../sonud/mt2701-afe-pcm.txt.
+
 Example:
 
-audsys: audsys at 11220000 {
-	compatible = "mediatek,mt7622-audsys", "syscon";
-	reg = <0 0x11220000 0 0x1000>;
-	#clock-cells = <1>;
-};
+	audsys: clock-controller at 11220000 {
+		compatible = "mediatek,mt7622-audsys", "syscon";
+		reg = <0 0x11220000 0 0x2000>;
+		#clock-cells = <1>;
+
+		afe: audio-controller {
+			...
+		};
+	};
-- 
1.9.1
