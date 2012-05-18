From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:14 +0100
Subject: [PATCH 15/16] ARM: ux500: Add regulator support for nomadik-i2c into
 the db8500 Device Tree
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we have full ab8500 and db8500-prcmu regulator support within DT
we can easily reference them from within each of the consumer's nodes.
Here we reference the ones used by each of the Nomadic I2C controllers.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index dcc5099..f1e0fb4 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -434,6 +434,7 @@
 			interrupts = <0 21 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			v-i2c-supply = <&db8500_vape_reg>;
 		};
 
 		i2c at 80122000 {
@@ -442,6 +443,7 @@
 			interrupts = <0 22 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			v-i2c-supply = <&db8500_vape_reg>;
 		};
 
 		i2c at 80128000 {
@@ -450,6 +452,7 @@
 			interrupts = <0 55 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			v-i2c-supply = <&db8500_vape_reg>;
 		};
 
 		i2c at 80110000 {
@@ -458,6 +461,7 @@
 			interrupts = <0 12 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			v-i2c-supply = <&db8500_vape_reg>;
 		};
 
 		i2c at 8012a000 {
@@ -466,6 +470,7 @@
 			interrupts = <0 51 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			v-i2c-supply = <&db8500_vape_reg>;
 		};
 
 		ssp at 80002000 {
-- 
1.7.9.5
