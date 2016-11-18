From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 18 Nov 2016 11:24:22 +0100
Subject: [PATCH 1/2] ARM: dts: r8a7743: Move RST node before SYSC node
In-Reply-To: <1479464663-19054-1-git-send-email-geert+renesas@glider.be>
References: <1479464663-19054-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1479464663-19054-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To preserve both alphabetical (label) and numerical ordering (unit
address).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7743.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 216cb1f37f87de9a..ca0cda28a3eb5241 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -102,17 +102,17 @@
 			#power-domain-cells = <0>;
 		};
 
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a7743-rst";
+			reg = <0 0xe6160000 0 0x100>;
+		};
+
 		sysc: system-controller at e6180000 {
 			compatible = "renesas,r8a7743-sysc";
 			reg = <0 0xe6180000 0 0x200>;
 			#power-domain-cells = <1>;
 		};
 
-		rst: reset-controller at e6160000 {
-			compatible = "renesas,r8a7743-rst";
-			reg = <0 0xe6160000 0 0x100>;
-		};
-
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a7743",
 				     "renesas,rcar-dmac";
-- 
1.9.1
