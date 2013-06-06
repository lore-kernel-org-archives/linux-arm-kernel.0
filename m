From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:17:00 +0100
Subject: [PATCH 12/33] ARM: ux500: Supply the MSP (Audio) clocks lookup to the
 DBX500 DT
In-Reply-To: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370521041-32318-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 6b9c3a4..e4ce16b 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -781,6 +781,10 @@
 			reg = <0x80123000 0x1000>;
 			interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 			v-ape-supply = <&db8500_vape_reg>;
+
+			clocks = <&prcc_kclk 1 3>, <&prcc_pclk 1 3>;
+			clock-names = "msp0", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -789,6 +793,10 @@
 			reg = <0x80124000 0x1000>;
 			interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
 			v-ape-supply = <&db8500_vape_reg>;
+
+			clocks = <&prcc_kclk 1 4>, <&prcc_pclk 1 4>;
+			clock-names = "msp1", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -798,6 +806,10 @@
 			reg = <0x80117000 0x1000>;
 			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
 			v-ape-supply = <&db8500_vape_reg>;
+
+			clocks = <&prcc_kclk 2 3>, <&prcc_pclk 2 5>;
+			clock-names = "msp2", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -806,6 +818,10 @@
 			reg = <0x80125000 0x1000>;
 			interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
 			v-ape-supply = <&db8500_vape_reg>;
+
+			clocks = <&prcc_kclk 1 10>, <&prcc_pclk 1 11>;
+			clock-names = "msp3", "apb_pclk";
+
 			status = "disabled";
 		};
 
-- 
1.7.10.4
