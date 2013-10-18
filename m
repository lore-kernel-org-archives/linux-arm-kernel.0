From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 18 Oct 2013 10:56:45 -0700
Subject: [PATCH v2 3/4] ARM: dts: MSM8974: Add MMIO architected timer node
In-Reply-To: <1382119006-22231-1-git-send-email-sboyd@codeaurora.org>
References: <1382034310-31147-1-git-send-email-rvaswani@codeaurora.org>
 <1382119006-22231-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1382119006-22231-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the mmio architected timer node.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 59 +++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index df18637..6ac9496 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -30,6 +30,65 @@
 			clock-frequency = <19200000>;
 		};
 
+		timer at f9020000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			compatible = "arm,armv7-timer-mem";
+			reg = <0xf9020000 0x1000>;
+			clock-frequency = <19200000>;
+
+			frame at f9021000 {
+				frame-number = <0>;
+				interrupts = <0 8 0x4>,
+					     <0 7 0x4>;
+				reg = <0xf9021000 0x1000>,
+				      <0xf9022000 0x1000>;
+			};
+
+			frame at f9023000 {
+				frame-number = <1>;
+				interrupts = <0 9 0x4>;
+				reg = <0xf9023000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at f9024000 {
+				frame-number = <2>;
+				interrupts = <0 10 0x4>;
+				reg = <0xf9024000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at f9025000 {
+				frame-number = <3>;
+				interrupts = <0 11 0x4>;
+				reg = <0xf9025000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at f9026000 {
+				frame-number = <4>;
+				interrupts = <0 12 0x4>;
+				reg = <0xf9026000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at f9027000 {
+				frame-number = <5>;
+				interrupts = <0 13 0x4>;
+				reg = <0xf9027000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at f9028000 {
+				frame-number = <6>;
+				interrupts = <0 14 0x4>;
+				reg = <0xf9028000 0x1000>;
+				status = "disabled";
+			};
+		};
+
 		restart at fc4ab000 {
 			compatible = "qcom,pshold";
 			reg = <0xfc4ab000 0x4>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
