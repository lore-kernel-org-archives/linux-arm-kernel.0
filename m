From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  3 Jun 2013 14:42:35 +0100
Subject: [PATCH 11/21] ARM: ux500: Supply the MSP (Audio) clocks lookup to the
 DBX500 DT
In-Reply-To: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370266965-7901-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index e5a5e9f..4701e75 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -773,6 +773,10 @@
 			reg = <0x80123000 0x1000>;
 			interrupts = <0 31 0x4>;
 			v-ape-supply = <&db8500_vape_reg>;
+
+			clocks = <&clk 86>, <&clk 43>;
+			clock-names = "msp0", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -781,6 +785,10 @@
 			reg = <0x80124000 0x1000>;
 			interrupts = <0 62 0x4>;
 			v-ape-supply = <&db8500_vape_reg>;
+
+			clocks = <&clk 87>, <&clk 44>;
+			clock-names = "msp1", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -790,6 +798,10 @@
 			reg = <0x80117000 0x1000>;
 			interrupts = <0 98 0x4>;
 			v-ape-supply = <&db8500_vape_reg>;
+
+			clocks = <&clk 95>, <&clk 57>;
+			clock-names = "msp2", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -798,6 +810,10 @@
 			reg = <0x80125000 0x1000>;
 			interrupts = <0 62 0x4>;
 			v-ape-supply = <&db8500_vape_reg>;
+
+			clocks = <&clk 92>, <&clk 51>;
+			clock-names = "msp3", "apb_pclk";
+
 			status = "disabled";
 		};
 
-- 
1.7.10.4
