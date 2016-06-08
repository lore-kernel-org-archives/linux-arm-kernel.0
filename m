From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:45 +0900
Subject: [PATCH 8/9] arm64: dts: salvator-x: Fix W=1 dtc warnings
In-Reply-To: <cover.1465347183.git.horms+renesas@verge.net.au>
References: <cover.1465347183.git.horms+renesas@verge.net.au>
Message-ID: <4a4e2138d6bb5e6b80e283df73c1acabb0b992f7.1465347183.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 4 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 84082922edb2..98f02631a0f0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -62,7 +62,7 @@
 		clock-frequency = <24576000>;
 	};
 
-	vcc_sdhi0: regulator at 1 {
+	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "SDHI0 Vcc";
@@ -73,7 +73,7 @@
 		enable-active-high;
 	};
 
-	vccq_sdhi0: regulator at 2 {
+	vccq_sdhi0: regulator-vccq-sdhi0 {
 		compatible = "regulator-gpio";
 
 		regulator-name = "SDHI0 VccQ";
@@ -86,7 +86,7 @@
 			  1800000 0>;
 	};
 
-	vcc_sdhi3: regulator at 3 {
+	vcc_sdhi3: regulator-vcc-sdhi3 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "SDHI3 Vcc";
@@ -97,7 +97,7 @@
 		enable-active-high;
 	};
 
-	vccq_sdhi3: regulator at 4 {
+	vccq_sdhi3: regulator-vccq-sdhi3 {
 		compatible = "regulator-gpio";
 
 		regulator-name = "SDHI3 VccQ";
-- 
2.1.4
