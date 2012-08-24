From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 24 Aug 2012 15:01:51 +0100
Subject: [PATCH 15/17] ARM: ux500: Add nodes for the MSP into Device Tree
In-Reply-To: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
References: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1345816913-4113-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch inserts all known MSP devices into the DBx5x0 Device Tree
disabled and enables the two important ones for the Snowball low-cost
development board.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi  |   33 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/snowball.dts |    8 ++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 7f8c9db..b297957 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -586,6 +586,39 @@
 			status = "disabled";
 		};
 
+		msp0: msp at 80123000 {
+			compatible = "stericsson,ux500-msp-i2s";
+			reg = <0x80123000 0x1000>;
+			interrupts = <0 31 0x4>;
+			v-ape-supply = <&db8500_vape_reg>;
+			status = "disabled";
+		};
+
+		msp1: msp at 80124000 {
+			compatible = "stericsson,ux500-msp-i2s";
+			reg = <0x80124000 0x1000>;
+			interrupts = <0 62 0x4>;
+			v-ape-supply = <&db8500_vape_reg>;
+			status = "disabled";
+		};
+
+		// HDMI sound
+		msp2: msp at 80117000 {
+			compatible = "stericsson,ux500-msp-i2s";
+			reg = <0x80117000 0x1000>;
+			interrupts = <0 98 0x4>;
+			v-ape-supply = <&db8500_vape_reg>;
+			status = "disabled";
+		};
+
+		msp3: msp at 80125000 {
+			compatible = "stericsson,ux500-msp-i2s";
+			reg = <0x80125000 0x1000>;
+			interrupts = <0 62 0x4>;
+			v-ape-supply = <&db8500_vape_reg>;
+			status = "disabled";
+		};
+
 		external-bus at 50000000 {
 			compatible = "simple-bus";
 			reg = <0x50000000 0x4000000>;
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index df6fc57..fce4a00 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -83,6 +83,14 @@
 	};
 
 	soc-u9500 {
+		msp1: msp at 80124000 {
+			status = "okay";
+		};
+
+		msp3: msp at 80125000 {
+			status = "okay";
+		};
+
 		external-bus at 50000000 {
 			status = "okay";
 
-- 
1.7.9.5
