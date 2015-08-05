From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed,  5 Aug 2015 10:32:46 -0600
Subject: [PATCH RFC 10/10] arm: dts: qcom: Add TCSR mutex device bindings for
 APQ8084
In-Reply-To: <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1438792366-2737-11-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device binding for hwspinlock support on QCOM 8084 SoCs.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 4a61f8d..2a08741 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -286,5 +286,16 @@
 			interrupt-controller;
 			#interrupt-cells = <4>;
 		};
+
+		tcsr_mutex_regs: syscon at fd484000{
+			compatible = "syscon";
+			reg = <0xfd484000 0x20000>;
+		};
+
+		tcsr_mutex: hwlock {
+			compatible = "qcom,tcsr-mutex";
+			syscon = <&tcsr_mutex_regs 0 0x80>;
+			#hwlock-cells = <1>;
+		};
 	};
 };
-- 
2.1.4
