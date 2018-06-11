From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 11 Jun 2018 15:53:40 -0700
Subject: [PATCH] ARM: dts: BCM5301x: Fix i2c controller interrupt type
Message-ID: <20180611225340.12733-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c controller should be using IRQ_TYPE_LEVEL_HIGH, fix that.

Fixes: bb097e3e0045 ("ARM: dts: BCM5301X: Add I2C support to the DT")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 9a076c409f4e..ef995e50ee12 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -365,7 +365,7 @@
 	i2c0: i2c at 18009000 {
 		compatible = "brcm,iproc-i2c";
 		reg = <0x18009000 0x50>;
-		interrupts = <GIC_SPI 121 IRQ_TYPE_NONE>;
+		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clock-frequency = <100000>;
-- 
2.14.1
