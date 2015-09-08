From: agross@codeaurora.org (Andy Gross)
Date: Tue,  8 Sep 2015 16:35:28 -0500
Subject: [PATCH 08/11] arm: dts: Add RPM/SMD support on APQ8084
In-Reply-To: <1441748131-26490-1-git-send-email-agross@codeaurora.org>
References: <1441748131-26490-1-git-send-email-agross@codeaurora.org>
Message-ID: <1441748131-26490-10-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for RPM and SMD nodes that are present on APQ8084
platforms.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index a7e34f9..c4303b9 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -114,6 +114,11 @@
 			      <0xf9002000 0x1000>;
 		};
 
+		apcs: syscon at f9011000 {
+			compatible = "syscon";
+			reg = <0xf9011000 0x1000>;
+		};
+
 		timer at f9020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -312,4 +317,19 @@
 			#interrupt-cells = <4>;
 		};
 	};
+
+	smd {
+		compatible = "qcom,smd";
+
+		rpm {
+			interrupts = <0 168 1>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests {
+				compatible = "qcom,rpm-apq8084";
+				qcom,smd-channels = "rpm_requests";
+			};
+		};
+	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
