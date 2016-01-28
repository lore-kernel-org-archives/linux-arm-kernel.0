From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 28 Jan 2016 17:44:09 +0000
Subject: [PATCH v2 7/9] arm64: dts: apq8016-sbc: make 1.8v available on LS
 expansion
In-Reply-To: <1454002960-3106-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454002960-3106-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1454003049-3414-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

96boards mezzanine boards on LS expansion require 1.8v as per 96boards
specifications, so enable the corresponding regulators and make them
always-on.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 601c0ff..279af22 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -230,9 +230,14 @@
 		regulator-max-microvolt = <3337000>;
 	};
 
+	/**
+	 * 1.8v required on LS expansion
+	 * for mezzanine boards
+	 */
 	l15 {
 		regulator-min-microvolt = <1750000>;
 		regulator-max-microvolt = <3337000>;
+		regulator-always-on;
 	};
 
 	l16 {
-- 
1.9.1
