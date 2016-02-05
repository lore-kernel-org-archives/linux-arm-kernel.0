From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri,  5 Feb 2016 19:01:44 +0000
Subject: [PATCH 5/6] arm64: dts: qcom: apq8016-sbc: enable lpass on DB410c
In-Reply-To: <1454698819-13885-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454698819-13885-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1454698904-14100-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the lpass on DB410C. LPASS is used as cpu dai for
both analog and digital audio.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index e80bdc2..cb52afb 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -186,6 +186,10 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&usb_sw_sel_pm>;
 		};
+
+		lpass at 07700000 {
+			status = "okay";
+		};
 	};
 };
 
-- 
1.9.1
