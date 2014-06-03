From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Tue,  3 Jun 2014 17:29:40 +0300
Subject: [PATCH v3 1/2] ARM: dts: qcom: Add APQ8084 Global Clock Controller DT
 node
In-Reply-To: <1401805781-26637-1-git-send-email-gdjakov@mm-sol.com>
References: <1401805781-26637-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <1401805781-26637-2-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the necessary node to probe the global clock
controller on APQ8084 platforms.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index e3e009a..1e785df 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -2,6 +2,8 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/clock/qcom,gcc-apq8084.h>
+
 / {
 	model = "Qualcomm APQ 8084";
 	compatible = "qcom,apq8084";
@@ -175,5 +177,13 @@
 			compatible = "qcom,pshold";
 			reg = <0xfc4ab000 0x4>;
 		};
+
+		gcc: clock-controller at fc400000 {
+			compatible = "qcom,gcc-apq8084";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			reg = <0xfc400000 0x4000>;
+		};
+
 	};
 };
-- 
1.7.9.5
