From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:59 +0900
Subject: [PATCH 29/30] ARM: dts: porter: Fix W=1 dtc warnings
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <afed0c94ee44ea701a849d1c9729f9b711729197.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 6a1bb1a8209b..e9151e946da8 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -46,7 +46,7 @@
 		reg = <2 0x00000000 0 0x40000000>;
 	};
 
-	vcc_sdhi0: regulator at 0 {
+	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "SDHI0 Vcc";
@@ -55,7 +55,7 @@
 		regulator-always-on;
 	};
 
-	vccq_sdhi0: regulator at 1 {
+	vccq_sdhi0: regulator-vccq-sdhi0 {
 		compatible = "regulator-gpio";
 
 		regulator-name = "SDHI0 VccQ";
@@ -68,7 +68,7 @@
 			  1800000 0>;
 	};
 
-	vcc_sdhi2: regulator at 2 {
+	vcc_sdhi2: regulator-vcc-sdhi2 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "SDHI2 Vcc";
@@ -77,7 +77,7 @@
 		regulator-always-on;
 	};
 
-	vccq_sdhi2: regulator at 3 {
+	vccq_sdhi2: regulator-vccq-sdhi2 {
 		compatible = "regulator-gpio";
 
 		regulator-name = "SDHI2 VccQ";
-- 
2.1.4
