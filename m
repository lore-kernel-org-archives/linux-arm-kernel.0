From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Jul 2012 13:45:59 +0100
Subject: [PATCH 15/18] ARM: ux500: Add MSP devices to DB8500 Device Tree
In-Reply-To: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343393162-11938-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

List all four MSP devices which exist on all DB8500 based platforms,
to ensure correct device probing and configuration passing when booting
with DT.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index a3fb05f..b9d4405 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -595,6 +595,36 @@
 			compatible = "stericsson,ux500-pcm";
 		};
 
+		msp0: msp at 80123000 {
+			compatible = "stericsson,ux500-msp-i2s";
+			reg = <0x80123000 0x1000>;
+			interrupts = <0 31 0x4>;
+			v-ape-supply = <&db8500_vape_reg>;
+		};
+
+		msp1: msp at 80124000 {
+			compatible = "stericsson,ux500-msp-i2s";
+			reg = <0x80124000 0x1000>;
+			interrupts = <0 62 0x4>;
+			v-ape-supply = <&db8500_vape_reg>;
+			stericcson,use-pinctrl;
+		};
+
+		// HDMI sound
+		msp2: msp at 80117000 {
+			compatible = "stericsson,ux500-msp-i2s";
+			reg = <0x80117000 0x1000>;
+			interrupts = <0 98 0x4>;
+			v-ape-supply = <&db8500_vape_reg>;
+		};
+
+		msp3: msp at 80125000 {
+			compatible = "stericsson,ux500-msp-i2s";
+			reg = <0x80125000 0x1000>;
+			interrupts = <0 62 0x4>;
+			v-ape-supply = <&db8500_vape_reg>;
+		};
+
 		external-bus at 50000000 {
 			compatible = "simple-bus";
 			reg = <0x50000000 0x4000000>;
-- 
1.7.9.5
