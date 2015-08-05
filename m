From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed,  5 Aug 2015 10:32:40 -0600
Subject: [PATCH RFC 04/10] arm: dts: Add L2 power-controller device bindings
 for APQ8084
In-Reply-To: <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1438792366-2737-5-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power controller (SAW) device nodes for L2 caches. L2 SAW enable L2
to enter idle states and be powered off. Also, on 8084 the L2 SAW may be
used to regulate the active voltage for the cpu and L2.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 7084010..900ef1f 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -59,7 +59,7 @@
 		};
 
 		L2: l2-cache {
-			compatible = "qcom,arch-cache";
+			compatible = "cache";
 			cache-level = <2>;
 			qcom,saw = <&saw_l2>;
 		};
@@ -183,7 +183,7 @@
 		};
 
 		saw_l2: power-controller at f9012000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,apq8084-saw2-v2.1-l2", "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
 			regulator;
 		};
-- 
2.1.4
