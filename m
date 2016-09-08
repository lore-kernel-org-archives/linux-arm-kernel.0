From: andy.yan@rock-chips.com (Andy Yan)
Date: Thu,  8 Sep 2016 19:03:43 +0800
Subject: [PATCH] arm64: rockchip: fix i2c resource describe error of rk3368
Message-ID: <1473332623-31951-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the TRM and downstream code from rockchip, the register
address of i2c1 on rk3368 is 0xff660000 and i2c2 is 0xff140000.

This patch fix the i2c1 & i2c2 register address definition error, also
fix the clk and pinctrl reference error.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 0fcb214..2f8e19f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -315,16 +315,16 @@
 		status = "disabled";
 	};
 
-	i2c1: i2c at ff140000 {
+	i2c2: i2c at ff140000 {
 		compatible = "rockchip,rk3368-i2c", "rockchip,rk3288-i2c";
 		reg = <0x0 0xff140000 0x0 0x1000>;
 		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clock-names = "i2c";
-		clocks = <&cru PCLK_I2C1>;
+		clocks = <&cru PCLK_I2C2>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&i2c1_xfer>;
+		pinctrl-0 = <&i2c2_xfer>;
 		status = "disabled";
 	};
 
@@ -554,16 +554,16 @@
 		status = "disabled";
 	};
 
-	i2c2: i2c at ff660000 {
+	i2c1: i2c at ff660000 {
 		compatible = "rockchip,rk3368-i2c", "rockchip,rk3288-i2c";
 		reg = <0x0 0xff660000 0x0 0x1000>;
 		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clock-names = "i2c";
-		clocks = <&cru PCLK_I2C2>;
+		clocks = <&cru PCLK_I2C1>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&i2c2_xfer>;
+		pinctrl-0 = <&i2c1_xfer>;
 		status = "disabled";
 	};
 
-- 
2.7.4
