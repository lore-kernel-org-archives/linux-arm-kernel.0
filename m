From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Sep 2018 13:12:42 -0500
Subject: [PATCH] arm64: dts: broadcom: Fix I2C and SPI bus warnings
Message-ID: <20180913181245.25484-18-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc has new checks for I2C and SPI buses. Fix the warnings in node names
and unit-addresses.

arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dtb: Warning (i2c_bus_reg): /hsls/i2c at e0000/pcf8574 at 20: I2C bus unit address format error, expected "27"
arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dtb: Warning (i2c_bus_reg): /hsls/i2c at e0000/pcf8574 at 20: I2C bus unit address format error, expected "27"
arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dtb: Warning (spi_bus_bridge): /hsls/ssp at 180000: node name for SPI buses should be 'spi'
arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dtb: Warning (spi_bus_bridge): /hsls/ssp at 190000: node name for SPI buses should be 'spi'

Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please apply to the sub-arch tree. The dtc changes haven't landed, but 
will for 4.20.

 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi          | 4 ++--
 arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi | 2 +-
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi       | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 1a406a76c86a..ea854f689fda 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -639,7 +639,7 @@
 			status = "disabled";
 		};
 
-		ssp0: ssp at 66180000 {
+		ssp0: spi at 66180000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x66180000 0x1000>;
 			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
@@ -650,7 +650,7 @@
 			status = "disabled";
 		};
 
-		ssp1: ssp at 66190000 {
+		ssp1: spi at 66190000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x66190000 0x1000>;
 			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
index bc299c3d9068..a9b92e52d50e 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
@@ -138,7 +138,7 @@
 &i2c1 {
 	status = "okay";
 
-	pcf8574: pcf8574 at 20 {
+	pcf8574: pcf8574 at 27 {
 		compatible = "nxp,pcf8574a";
 		gpio-controller;
 		#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index e283480bfc7e..cfeaa855bd05 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -521,7 +521,7 @@
 			status = "disabled";
 		};
 
-		ssp0: ssp at 180000 {
+		ssp0: spi at 180000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x00180000 0x1000>;
 			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
@@ -533,7 +533,7 @@
 			status = "disabled";
 		};
 
-		ssp1: ssp at 190000 {
+		ssp1: spi at 190000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x00190000 0x1000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1
