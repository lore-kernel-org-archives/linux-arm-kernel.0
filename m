From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Feb 2014 23:16:53 -0700
Subject: [PATCH 2/2] ARM: bcm2835: fix clock DT node names
In-Reply-To: <1392358613-19962-1-git-send-email-swarren@wwwdotorg.org>
References: <1392358613-19962-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1392358613-19962-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT nodes should be named according to the type of object that they
represent rather than the identity. DT nodes that contain a reg
property should include a unit address in their name. Fix these issues.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
This is the bcm2835 patch which depends on patch 1. I guess this could
also go through the clk tree if that makes it easier, although there's
always the small risk of conflicts if you do that.

 arch/arm/boot/dts/bcm2835.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index a2d4889..1cf1ae7 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -155,21 +155,21 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk_mmc: mmc {
+		clk_mmc: clock at 0 {
 			compatible = "fixed-clock";
 			reg = <0>;
 			#clock-cells = <0>;
 			clock-frequency = <100000000>;
 		};
 
-		clk_i2c: i2c {
+		clk_i2c: clock at 1 {
 			compatible = "fixed-clock";
 			reg = <1>;
 			#clock-cells = <0>;
 			clock-frequency = <250000000>;
 		};
 
-		clk_spi: spi {
+		clk_spi: clock at 2 {
 			compatible = "fixed-clock";
 			reg = <2>;
 			#clock-cells = <0>;
-- 
1.8.3.2
