From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 19 Nov 2018 22:39:27 +0530
Subject: [PATCH 04/16] arm: dts: Add devicetree for RDA8810PL SoC
In-Reply-To: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181119170939.19153-5-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device tree for RDA8810PL SoC from RDA Microelectronics.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 95 ++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
new file mode 100644
index 000000000000..7f1ff2021eff
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -0,0 +1,95 @@
+/*
+ * RDA8810PL SoC
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ * Copyright (c) 2018 Manivannan Sadhasivam
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/ {
+	compatible = "rda,8810pl";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			reg = <0x0>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x80000000>;
+
+		sram at 100000 {
+			compatible = "mmio-sram";
+			reg = <0x100000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+		};
+
+		apb at 20800000 {
+			compatible = "simple-bus";
+			reg = <0x20800000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x20800000 0x100000>;
+		};
+
+		apb at 20900000 {
+			compatible = "simple-bus";
+			reg = <0x20900000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x20900000 0x100000>;
+		};
+
+		apb at 20a00000 {
+			compatible = "simple-bus";
+			reg = <0x20a00000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x20a00000 0x100000>;
+
+			uart0: serial at 0 {
+				compatible = "rda,8810pl-uart";
+				reg = <0x0 0x1000>;
+				status = "disabled";
+			};
+
+			uart1: serial at 10000 {
+				compatible = "rda,8810pl-uart";
+				reg = <0x10000 0x1000>;
+				status = "disabled";
+			};
+
+			uart2: serial at 90000 {
+				compatible = "rda,8810pl-uart";
+				reg = <0x90000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		l2: cache-controller at 21100000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x21100000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+};
-- 
2.17.1
