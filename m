From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Jan 2017 15:08:19 +0100
Subject: [PATCH 1/8] clk: renesas: cpg-mssr: Document reset control support
In-Reply-To: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
References: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1484921306-9967-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document properties needed to use the Reset Control feature of the
Renesas Clock Pulse Generator / Module Standby and Software Reset
module.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
index c469194129536332..f4f944d813081857 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
@@ -42,6 +42,10 @@ Required Properties:
 	Domain bindings in
 	Documentation/devicetree/bindings/power/power_domain.txt.
 
+  - #reset-cells: Must be 1
+      - The single reset specifier cell must be the module number, as defined
+	in the datasheet.
+
 
 Examples
 --------
@@ -55,6 +59,7 @@ Examples
 		clock-names = "extal", "extalr";
 		#clock-cells = <2>;
 		#power-domain-cells = <0>;
+		#reset-cells = <1>;
 	};
 
 
@@ -69,5 +74,6 @@ Examples
 		dmas = <&dmac1 0x13>, <&dmac1 0x12>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg>;
+		resets = <&cpg 310>;
 		status = "disabled";
 	};
-- 
1.9.1
