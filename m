From: tinamdar@apm.com (Tanmay Inamdar)
Date: Mon, 23 Dec 2013 13:32:03 +0530
Subject: [RFC PATCH 2/3] arm64: dts: APM X-Gene PCIe device tree nodes
In-Reply-To: <1387785725-24262-1-git-send-email-tinamdar@apm.com>
References: <1387785725-24262-1-git-send-email-tinamdar@apm.com>
Message-ID: <1387785725-24262-3-git-send-email-tinamdar@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree nodes for APM X-Gene PCIe controller and
PCIe clock interface. Since X-Gene SOC supports maximum 5 ports, 5 dts nodes
are added.

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 arch/arm64/boot/dts/apm-mustang.dts |    4 +
 arch/arm64/boot/dts/apm-storm.dtsi  |  140 +++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-mustang.dts b/arch/arm64/boot/dts/apm-mustang.dts
index 1247ca1..ab2b95f 100644
--- a/arch/arm64/boot/dts/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm-mustang.dts
@@ -24,3 +24,7 @@
 		reg = < 0x1 0x00000000 0x0 0x80000000 >; /* Updated by bootloader */
 	};
 };
+
+&pcie0 {
+	status = "ok";
+};
diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index d37d736..b82f430 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -176,6 +176,146 @@
 				reg-names = "csr-reg";
 				clock-output-names = "eth8clk";
 			};
+
+			pcie0clk: pcie0clk at 1f2bc000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				clock-names = "pcie0clk";
+				reg = <0x0 0x1f2bc000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				clock-output-names = "pcie0clk";
+			};
+
+			pcie1clk: pcie1clk at 1f2cc000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				clock-names = "pcie1clk";
+				reg = <0x0 0x1f2cc000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				clock-output-names = "pcie1clk";
+			};
+
+			pcie2clk: pcie2clk at 1f2dc000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				clock-names = "pcie2clk";
+				reg = <0x0 0x1f2dc000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				clock-output-names = "pcie2clk";
+			};
+
+			pcie3clk: pcie3clk at 1f50c000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				clock-names = "pcie3clk";
+				reg = <0x0 0x1f50c000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				clock-output-names = "pcie3clk";
+			};
+
+			pcie4clk: pcie4clk at 1f51c000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				clock-names = "pcie4clk";
+				reg = <0x0 0x1f51c000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				clock-output-names = "pcie4clk";
+			};
+		};
+
+		pcie0: pcie at 1f2b0000 {
+			status = "disabled";
+			device_type = "pci";
+			compatible = "apm,xgene-pcie";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = < 0x00 0x1f2b0000 0x0 0x00010000>;
+			ranges = <0x02000000 0x0 0x00000000 0xe0 0x00000000 0x0 0x10000000 /* mem*/
+				  0x01000000 0x0 0x80000000 0xe0 0x80000000 0x0 0x00010000 /* io */
+				  0x00000000 0x0 0xd0000000 0xe0 0xd0000000 0x0 0x00200000 /* cfg */
+				  0x00000000 0x0 0x79000000 0x00 0x79000000 0x0 0x00800000>; /* msi */
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0xc2 0x1>;
+			clocks = <&pcie0clk 0>;
+			clock-names = "pcieclk";
+		};
+
+		pcie1: pcie at 1f2c0000 {
+			status = "disabled";
+			device_type = "pci";
+			compatible = "apm,xgene-pcie";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <0x00 0x1f2c0000 0x0 0x00010000>;
+			ranges = <0x02000000 0x0 0x00000000 0xd0 0x00000000 0x0 0x10000000 /* mem*/
+				  0x01000000 0x0 0x80000000 0xd0 0x80000000 0x0 0x00010000 /* io */
+				  0x00000000 0x0 0xd0000000 0xd0 0xd0000000 0x0 0x00200000 /* cfg */
+				  0x00000000 0x0 0x79000000 0x00 0x79000000 0x0 0x00800000>; /* msi */
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0xc8 0x1>;
+			clocks = <&pcie1clk 0>;
+			clock-names = "pcieclk";
+		};
+
+		pcie2: pcie at 1f2d0000 {
+			status = "disabled";
+			device_type = "pci";
+			compatible = "apm,xgene-pcie";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg =  <0x00 0x1f2d0000 0x0 0x00010000>;
+			ranges = <0x02000000 0x0 0x00000000 0x90 0x00000000 0x0 0x10000000 /* mem*/
+				  0x01000000 0x0 0x80000000 0x90 0x80000000 0x0 0x00010000 /* io */
+				  0x00000000 0x0 0xd0000000 0x90 0xd0000000 0x0 0x00200000 /* cfg */
+				  0x00000000 0x0 0x79000000 0x00 0x79000000 0x0 0x00800000>; /* msi */
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0xce 0x1>;
+			clocks = <&pcie3clk 0>;
+			clock-names = "pcieclk";
+		};
+
+		pcie3: pcie at 1f500000 {
+			status = "disabled";
+			device_type = "pci";
+			compatible = "apm,xgene-pcie";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <0x00 0x1f500000 0x0 0x00010000>;
+			ranges = <0x02000000 0x0 0x00000000 0xa0 0x00000000 0x0 0x10000000 /* mem*/
+				  0x01000000 0x0 0x80000000 0xa0 0x80000000 0x0 0x00010000 /* io */
+				  0x00000000 0x0 0xd0000000 0xa0 0xd0000000 0x0 0x00200000 /* cfg */
+				  0x00000000 0x0 0x79000000 0x00 0x79000000 0x0 0x00800000>; /* msi */
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0xd4 0x1>;
+			clocks = <&pcie3clk 0>;
+			clock-names = "pcieclk";
+		};
+
+		pcie4: pcie at 1f510000 {
+			status = "disabled";
+			device_type = "pci";
+			compatible = "apm,xgene-pcie";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <0x00 0x1f510000 0x0 0x00010000>;
+			ranges = <0x02000000 0x0 0x00000000 0xc0 0x00000000 0x0 0x10000000 /* mem*/
+				  0x01000000 0x0 0x80000000 0xc0 0x80000000 0x0 0x00010000 /* io */
+				  0x00000000 0x0 0xd0000000 0xc0 0xd0000000 0x0 0x00200000 /* cfg */
+				  0x00000000 0x0 0x79000000 0x00 0x79000000 0x0 0x00800000>; /* msi */
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0xda 0x1>;
+			clocks = <&pcie4clk 0>;
+			clock-names = "pcieclk";
 		};
 
 		serial0: serial at 1c020000 {
-- 
1.7.9.5
