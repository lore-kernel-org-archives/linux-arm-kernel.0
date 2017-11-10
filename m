From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Fri, 10 Nov 2017 14:36:06 +0800
Subject: [PATCH V4 11/12] arm64: dts: add syscon for whale2 platform
In-Reply-To: <20171110063607.3250-1-chunyan.zhang@spreadtrum.com>
References: <20171110063607.3250-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20171110063607.3250-12-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks on SC9860 are in the same address area with syscon
devices, the proper syscon node will be quoted under the
definitions of those clocks in DT.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi | 46 +++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 7c217c5..6ea3a75 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -17,6 +17,51 @@
 		#size-cells = <2>;
 		ranges;
 
+		ap_ahb_regs: syscon at 20210000 {
+			compatible = "syscon";
+			reg = <0 0x20210000 0 0x10000>;
+		};
+
+		pmu_regs: syscon at 402b0000 {
+			compatible = "syscon";
+			reg = <0 0x402b0000 0 0x10000>;
+		};
+
+		aon_regs: syscon at 402e0000 {
+			compatible = "syscon";
+			reg = <0 0x402e0000 0 0x10000>;
+		};
+
+		ana_regs: syscon at 40400000 {
+			compatible = "syscon";
+			reg = <0 0x40400000 0 0x10000>;
+		};
+
+		agcp_regs: syscon at 415e0000 {
+			compatible = "syscon";
+			reg = <0 0x415e0000 0 0x1000000>;
+		};
+
+		vsp_regs: syscon at 61100000 {
+			compatible = "syscon";
+			reg = <0 0x61100000 0 0x10000>;
+		};
+
+		cam_regs: syscon at 62100000 {
+			compatible = "syscon";
+			reg = <0 0x62100000 0 0x10000>;
+		};
+
+		disp_regs: syscon at 63100000 {
+			compatible = "syscon";
+			reg = <0 0x63100000 0 0x10000>;
+		};
+
+		ap_apb_regs: syscon at 70b00000 {
+			compatible = "syscon";
+			reg = <0 0x70b00000 0 0x40000>;
+		};
+
 		ap-apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -59,7 +104,6 @@
 				status = "disabled";
 			};
 		};
-
 	};
 
 	ext_26m: ext-26m {
-- 
2.7.4
