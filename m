From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 May 2016 09:10:14 +0200
Subject: [PATCH v2 23/23] arm64: dts: salvator-x: Fix W=1 dtc warnings
In-Reply-To: <1463728214-13838-1-git-send-email-geert+renesas@glider.be>
References: <1463728214-13838-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1463728214-13838-24-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 4 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 84082922edb219ab..98f02631a0f0c66c 100644
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
1.9.1
