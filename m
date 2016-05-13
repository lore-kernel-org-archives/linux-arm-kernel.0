From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 13 May 2016 09:56:01 +0200
Subject: [PATCH 21/23] ARM: dts: silk: Fix W=1 dtc warnings
In-Reply-To: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
References: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1463126163-29423-22-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 4 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794-silk.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index 56d98d5b21850cd2..b8c7a63c5ec456bc 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -32,7 +32,7 @@
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
-	d3_3v: regulator at 0 {
+	d3_3v: regulator-d3-3v {
 		compatible = "regulator-fixed";
 		regulator-name = "D3.3V";
 		regulator-min-microvolt = <3300000>;
@@ -41,7 +41,7 @@
 		regulator-always-on;
 	};
 
-	vcc_sdhi1: regulator at 3 {
+	vcc_sdhi1: regulator-vcc-sdhi1 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "SDHI1 Vcc";
@@ -52,7 +52,7 @@
 		enable-active-high;
 	};
 
-	vccq_sdhi1: regulator at 4 {
+	vccq_sdhi1: regulator-vccq-sdhi1 {
 		compatible = "regulator-gpio";
 
 		regulator-name = "SDHI1 VccQ";
-- 
1.9.1
