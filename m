From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 23 Nov 2015 21:54:34 -0800
Subject: [PATCH] ARM: dts: qcom: msm8974: Add i2c8 node
Message-ID: <1448344474-32311-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index acd4cdb9c934..777adb9204c7 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -331,6 +331,17 @@
 			interrupts = <0 208 0>;
 		};
 
+		blsp_i2c8: i2c at f9964000 {
+			status = "disabled";
+			compatible = "qcom,i2c-qup-v2.1.1";
+			reg = <0xf9964000 0x1000>;
+			interrupts = <0 102 IRQ_TYPE_NONE>;
+			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		blsp_i2c11: i2c at f9967000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
-- 
2.4.2
