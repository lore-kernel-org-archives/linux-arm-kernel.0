From: vigneshr@ti.com (Vignesh R)
Date: Fri, 31 Oct 2014 13:16:43 +0530
Subject: [PATCH 3/3] arm: boot: dts: am4372: add tscadc DT entries for
 am437x-evm and am43x-epos-evm
In-Reply-To: <1414741603-18233-1-git-send-email-vigneshr@ti.com>
References: <1414741603-18233-1-git-send-email-vigneshr@ti.com>
Message-ID: <1414741603-18233-4-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds tscadc DT entries for am437x-gp-evm and am43x-epos-evm.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi        | 20 ++++++++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts  |  8 ++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts |  8 ++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 46660ffd2b65..fd2de8f256e6 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -667,6 +667,26 @@
 			};
 		};
 
+		tscadc: tscadc at 44e0d000 {
+			compatible = "ti,am4372-tscadc","ti,am3359-tscadc";
+			reg = <0x44e0d000 0x1000>;
+			ti,hwmods = "adc_tsc";
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&adc_tsc_fck>;
+			clock-names = "fck";
+			status = "disabled";
+
+			tsc {
+				compatible = "ti,am4372-tsc", "ti,am3359-tsc";
+			};
+
+			adc {
+				#io-channel-cells = <1>;
+				compatible = "ti,am4372-adc", "ti,am3359-adc";
+			};
+
+		};
+
 		sham: sham at 53100000 {
 			compatible = "ti,omap5-sham";
 			ti,hwmods = "sham";
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index e7ac47fa6615..2ffd6d6dcc87 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -343,6 +343,14 @@
 	status = "okay";
 };
 
+&tscadc {
+	status = "okay";
+
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
+
 &ecap0 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index ac3e4859935f..f9bc607f3b3a 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -519,6 +519,14 @@
 	status = "okay";
 };
 
+&tscadc {
+	status = "okay";
+
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
+
 &ecap0 {
 		status = "okay";
 		pinctrl-names = "default";
-- 
1.9.1
