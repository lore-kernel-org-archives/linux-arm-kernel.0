From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Jul 2013 17:43:40 -0700
Subject: [PATCH v1 12/14] ARM: dts: msm: Add MSM8960 MMCC DT nodes
In-Reply-To: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
References: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374713022-6049-13-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary DT data to probe the multimedia clock controller
on MSM8960 devices.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/msm8960-cdp.dts | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/msm8960-cdp.dts b/arch/arm/boot/dts/msm8960-cdp.dts
index 76a1817..be8d947 100644
--- a/arch/arm/boot/dts/msm8960-cdp.dts
+++ b/arch/arm/boot/dts/msm8960-cdp.dts
@@ -109,6 +109,43 @@
 		};
 	};
 
+	clock-controller at 4000000 {
+		compatible = "qcom,mmcc-8960", "qcom,mmcc";
+		reg = <0x4000000 0x1000>;
+
+		clocks {
+			pll2: pll2 {
+				#clock-cells = <0>;
+				compatible = "qcom,pll";
+				clocks = <&pxo>;
+			};
+
+			mdp_rcg: mdp_rcg {
+				#clock-cells = <0>;
+				compatible = "qcom,mn8-dyn-clock";
+				clocks = <&pxo>, <&pll2>, <&vpll8>;
+			};
+
+			mdp_cxc: mdp_cxc {
+				#clock-cells = <0>;
+				compatible = "qcom,cxc-clock";
+				clocks = <&mdp_rcg>;
+			};
+
+			rot_rcg: rot_rcg {
+				#clock-cells = <0>;
+				compatible = "qcom,p4-dyn-clock";
+				clocks = <&pxo>, <&pll2>, <&vpll8>;
+			};
+
+			rot_cxc: rot_cxc {
+				#clock-cells = <0>;
+				compatible = "qcom,cxc-clock";
+				clocks = <&rot_rcg>;
+			};
+		};
+	};
+
 	serial at 16440000 {
 		compatible = "qcom,msm-hsuart", "qcom,msm-uart";
 		reg = <0x16440000 0x1000>,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
