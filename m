From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 10 Feb 2016 11:37:03 +0000
Subject: [PATCH v2 5/8] arm64: dts: qcom: apq8016-sbc: enable lpass on DB410c
In-Reply-To: <1455104164-29356-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455104164-29356-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1455104223-10687-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the lpass on DB410C. LPASS is used as cpu dai for
both analog and digital audio.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 23ba95a..8ab87e7 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -172,6 +172,10 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&usb_sw_sel_pm>;
 		};
+
+		lpass at 07708000 {
+			status = "okay";
+		};
 	};
 
 	usb2513 {
-- 
1.9.1
