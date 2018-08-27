From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Mon, 27 Aug 2018 09:11:12 -0600
Subject: [PATCH 9/9] arm64: dts: Add interconnect for the GPU on SDM845
In-Reply-To: <20180827151112.25211-1-jcrouse@codeaurora.org>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
Message-ID: <20180827151112.25211-10-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the interconnect properties for the GPU on SDM845
and set the corresponding OPP bandwidth values.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 10db0ceb3699..1e67f4fdd7d1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -198,36 +198,43 @@ gpu_opp_table: adreno-opp-table {
 		opp-710000000 {
 			opp-hz = /bits/ 64 <710000000>;
 			qcom,level = <416>;
+			opp-interconnect-bw-port0 = /bits/ 64 <0 7216000000>;
 		};
 
 		opp-675000000 {
 			opp-hz = /bits/ 64 <675000000>;
 			qcom,level = <384>;
+			opp-interconnect-bw-port0 = /bits/ 64 <0 7216000000>;
 		};
 
 		opp-596000000 {
 			opp-hz = /bits/ 64 <596000000>;
 			qcom,level = <320>;
+			opp-interconnect-bw-port0 = /bits/ 64 <0 5184000000>;
 		};
 
 		opp-520000000 {
 			opp-hz = /bits/ 64 <520000000>;
 			qcom,level = <256>;
+			opp-interconnect-bw-port0 = /bits/ 64 <0 4068000000>;
 		};
 
 		opp-414000000 {
 			opp-hz = /bits/ 64 <414000000>;
 			qcom,level = <192>;
+			opp-interconnect-bw-port0 = /bits/ 64 <0 3072000000>;
 		};
 
 		opp-342000000 {
 			opp-hz = /bits/ 64 <342000000>;
 			qcom,level = <128>;
+			opp-interconnect-bw-port0 = /bits/ 64 <0 2188000000>;
 		};
 
 		opp-257000000 {
 			opp-hz = /bits/ 64 <257000000>;
 			qcom,level = <64>;
+			opp-interconnect-bw-port0 = /bits/ 64 <0 1200000000>;
 		};
 	};
 
@@ -418,6 +425,9 @@ gpu_opp_table: adreno-opp-table {
 
 			operating-points-v2 = <&gpu_opp_table>;
 
+			interconnects = <&qnoc 26 &qnoc 512>;
+			interconnect-names = "port0";
+
 			qcom,gmu = <&gmu>;
 		};
 
-- 
2.18.0
