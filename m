From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Tue,  3 Jun 2014 17:29:41 +0300
Subject: [PATCH v3 2/2] ARM: dts: qcom: Add APQ8084 serial port DT node
In-Reply-To: <1401805781-26637-1-git-send-email-gdjakov@mm-sol.com>
References: <1401805781-26637-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <1401805781-26637-3-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary DT node to probe the serial driver on
APQ8084 platforms.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084-mtp.dts |    6 ++++++
 arch/arm/boot/dts/qcom-apq8084.dtsi    |    8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084-mtp.dts b/arch/arm/boot/dts/qcom-apq8084-mtp.dts
index 9dae387..8ecec58 100644
--- a/arch/arm/boot/dts/qcom-apq8084-mtp.dts
+++ b/arch/arm/boot/dts/qcom-apq8084-mtp.dts
@@ -3,4 +3,10 @@
 / {
 	model = "Qualcomm APQ 8084-MTP";
 	compatible = "qcom,apq8084-mtp", "qcom,apq8084";
+
+	soc {
+		serial at f995e000 {
+			status = "okay";
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 1e785df..b5b156e 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -185,5 +185,13 @@
 			reg = <0xfc400000 0x4000>;
 		};
 
+		serial at f995e000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0xf995e000 0x1000>;
+			interrupts = <0 114 0x0>;
+			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5
