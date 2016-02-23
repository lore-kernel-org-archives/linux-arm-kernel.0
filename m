From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 16:50:28 +0000
Subject: [PATCH v3 5/8] arm64: dts: qcom: apq8016-sbc: enable lpass on DB410c
In-Reply-To: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456246228-18299-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the lpass on DB410C. LPASS is used as cpu dai for
both analog and digital audio.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 15bb485..27288ee 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -154,6 +154,10 @@
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
