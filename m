From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 23 Feb 2018 15:02:09 +0100
Subject: [PATCH] arm: zynq: Use i2c-mux instead of i2cswitch for pca9548
Message-ID: <5ea002abef0c3c2ef7fe04360c916c0db72f2619.1519394527.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c muxes should described like this.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Based on Rob's comment https://patchwork.kernel.org/patch/10175211/

---
 arch/arm/boot/dts/zynq-zc702.dts | 2 +-
 arch/arm/boot/dts/zynq-zc706.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index d96979644e49..c0384376d7e0 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -105,7 +105,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c0_default>;
 
-	i2cswitch at 74 {
+	i2c-mux at 74 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index d0f51d0d6c95..886d20c4fdd5 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -61,7 +61,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c0_default>;
 
-	i2cswitch at 74 {
+	i2c-mux at 74 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.9.1
