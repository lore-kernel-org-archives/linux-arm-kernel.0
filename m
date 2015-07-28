From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 28 Jul 2015 13:54:18 +0100
Subject: [PATCH v1 5/7] ARM: dts: ifc6410: enable MDP support
In-Reply-To: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1438088058-17522-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables MDP support on IFC6410.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 1fc2ea5..1ab71f1 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -111,6 +111,16 @@
 			regulator-boot-on;
 		};
 
+		hdmi: qcom,hdmi-tx at 4a00000 {
+			status = "okay";
+			core-vdda-supply = <&pm8921_hdmi_switch>;
+			hdmi-mux-supply = <&ext_3p3v>;
+		};
+
+		mdp: qcom,mdp at 5100000 {
+			status = "okay";
+		};
+
 		gsbi3: gsbi at 16200000 {
 			status = "okay";
 			qcom,mode = <GSBI_PROT_I2C>;
-- 
1.9.1
