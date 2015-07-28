From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 28 Jul 2015 13:54:27 +0100
Subject: [PATCH v1 6/7] ARM: dts: qs600: enable MDP support
In-Reply-To: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1438088067-17564-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables MDP support on QS600 platform.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index 3ca1b80..75411ab 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -83,6 +83,16 @@
 			};
 		};
 
+		hdmi: qcom,hdmi-tx at 4a00000 {
+			status = "okay";
+			core-vdda-supply = <&pm8921_hdmi_switch>;
+			hdmi-mux-supply = <&v3p3_fixed>;
+		};
+
+		mdp: qcom,mdp at 5100000 {
+			status = "okay";
+		};
+
 		gsbi at 12440000 {
 			status = "okay";
 			qcom,mode = <GSBI_PROT_I2C>;
-- 
1.9.1
