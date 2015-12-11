From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 11 Dec 2015 18:32:11 +0000
Subject: [PATCH 3/4] arm: dts: apq8064: add hwspinlock nodes
In-Reply-To: <1449858409-13296-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1449858409-13296-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1449858731-13561-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support hwspinlock devicetree node.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 09f0e27..829028a 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -670,5 +670,17 @@
 			compatible = "qcom,tcsr-apq8064", "syscon";
 			reg = <0x1a400000 0x100>;
 		};
+
+		sfpb_syscon:syscon at 01200600 {
+			compatible = "syscon";
+			reg = <0x01200600 0x100>;
+		};
+
+		sfpb_mutex: hwlock {
+			compatible = "qcom,sfpb-mutex";
+			syscon = <&sfpb_syscon 0x4 0x4>;
+			#hwlock-cells = <1>;
+		};
+
 	};
 };
-- 
1.9.1
