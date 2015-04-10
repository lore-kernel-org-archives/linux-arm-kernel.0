From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Apr 2015 21:44:15 +0100
Subject: [PATCH v3 07/11] ARM: dts: apq8064: Add usb host support to CM QS-600
In-Reply-To: <1428698491-11881-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428698491-11881-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1428698655-12198-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Dechesne <nicolas.dechesne@linaro.org>

This patch adds device tree nodes to support two usb hosts on Compulab QS600 board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
[Srinivas Kandagatla: fixed up regulators and status properties]
Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index 142885d..4eedfe4 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -101,6 +101,28 @@
 			};
 		};
 
+		usb3_phy: phy at 12520000 {
+			status		= "okay";
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l23>;
+		};
+
+		usb4_phy: phy at 12530000 {
+			status		= "okay";
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l23>;
+		};
+
+		usb3: usb at 12520000 {
+			status = "okay";
+		};
+
+		usb4: usb at 12530000 {
+			status = "okay";
+		};
+
 		amba {
 			/* eMMC */
 			sdcc1: sdcc at 12400000 {
-- 
1.9.1
