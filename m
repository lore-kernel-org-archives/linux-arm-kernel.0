From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Mon, 14 Aug 2017 13:37:57 +0200
Subject: [RESEND PATCH 3/3] arm64: dts: apq8096-db820c: never disable
 regulator on LS expansion
In-Reply-To: <20170814113757.31010-1-srinivas.kandagatla@linaro.org>
References: <20170814113757.31010-1-srinivas.kandagatla@linaro.org>
Message-ID: <20170814113757.31010-3-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

1.8v regulator on LS expansion should not be disabled anytime to comply
with 96boards spec. So make this explicit with always-on flag.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 18c61693529e..0c10bbe55317 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -189,9 +189,15 @@
 					regulator-min-microvolt = <1300000>;
 					regulator-max-microvolt = <1300000>;
 				};
+
+				/**
+				 * 1.8v required on LS expansion
+				 * for mezzanine boards
+				 */
 				s4 {
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
 				};
 				s5 {
 					regulator-min-microvolt = <2150000>;
-- 
2.11.0
