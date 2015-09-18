From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 18 Sep 2015 13:31:12 +0100
Subject: [PATCH 04/14] devicetree: Add hardware rng entry to qcom-apq8064.dtsi
In-Reply-To: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1442579472-20102-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Stultz <john.stultz@linaro.org>

Add devicetree data to add support for hw_rng support
to the apq8064 dts.

Tested on the Nexus7 (2013).

Cc: Kumar Gala <galak@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree at vger.kernel.org
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 53d5311..d973832 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -315,6 +315,13 @@
 			};
 		};
 
+		rng at 1a500000 {
+			compatible = "qcom,prng";
+			reg = <0x1a500000 0x200>;
+			clocks = <&gcc PRNG_CLK>;
+			clock-names = "core";
+		};
+
 		qcom,ssbi at 500000 {
 			compatible = "qcom,ssbi";
 			reg = <0x00500000 0x1000>;
-- 
1.9.1
