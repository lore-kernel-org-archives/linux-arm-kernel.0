From: ttnguyen@apm.com (Tai Nguyen)
Date: Thu, 31 Mar 2016 16:37:52 -0700
Subject: [PATCH 4/4] arm64: dts: apm: Add APM X-Gene SoC PMU DTS entries
In-Reply-To: <1459467472-31561-1-git-send-email-ttnguyen@apm.com>
References: <1459467472-31561-1-git-send-email-ttnguyen@apm.com>
Message-ID: <1459467472-31561-5-git-send-email-ttnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: dts: apm: Add APM X-Gene SoC PMU DTS entries

Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 60 ++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 6c5ed11..dc3d20b7 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -517,6 +517,66 @@
 			};
 		};
 
+		pmu: pmu at 78810000 {
+			compatible = "apm,xgene-pmu-v2";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			regmap-csw = <&csw>;
+			regmap-mcba = <&mcba>;
+			regmap-mcbb = <&mcbb>;
+			reg = <0x0 0x78810000 0x0 0x1000>;
+			interrupts = <0x0 0x22 0x4>;
+
+			pmul3c at 7e610000 {
+				compatible = "apm,xgene-pmu-l3c";
+				reg = <0x0 0x7e610000 0x0 0x1000>;
+				index = <0>;
+			};
+
+			pmuiob at 7e940000 {
+				compatible = "apm,xgene-pmu-iob";
+				reg = <0x0 0x7e940000 0x0 0x1000>;
+				index = <0>;
+			};
+
+			pmucmcb at 7e710000 {
+				compatible = "apm,xgene-pmu-mcb";
+				reg = <0x0 0x7e710000 0x0 0x1000>;
+				index = <0>;
+			};
+
+			pmucmcb at 7e730000 {
+				compatible = "apm,xgene-pmu-mcb";
+				reg = <0x0 0x7e730000 0x0 0x1000>;
+				index = <1>;
+			};
+
+			pmucmc at 7e810000 {
+				compatible = "apm,xgene-pmu-mc";
+				reg = <0x0 0x7e810000 0x0 0x1000>;
+				index = <0>;
+			};
+
+			pmucmc at 7e850000 {
+				compatible = "apm,xgene-pmu-mc";
+				reg = <0x0 0x7e850000 0x0 0x1000>;
+				index = <1>;
+			};
+
+			pmucmc at 7e890000 {
+				compatible = "apm,xgene-pmu-mc";
+				reg = <0x0 0x7e890000 0x0 0x1000>;
+				index = <2>;
+			};
+
+			pmucmc at 7e8d0000 {
+				compatible = "apm,xgene-pmu-mc";
+				reg = <0x0 0x7e8d0000 0x0 0x1000>;
+				index = <3>;
+			};
+		};
+
 		pcie0: pcie at 1f2b0000 {
 			status = "disabled";
 			device_type = "pci";
-- 
1.9.1
