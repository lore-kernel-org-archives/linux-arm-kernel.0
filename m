From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Mon, 14 Aug 2017 13:37:56 +0200
Subject: [RESEND PATCH 2/3] arm64: dts: apq8096-db820c: Enable on board 3 pcie
 root complex
In-Reply-To: <20170814113757.31010-1-srinivas.kandagatla@linaro.org>
References: <20170814113757.31010-1-srinivas.kandagatla@linaro.org>
Message-ID: <20170814113757.31010-2-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds enables 3 instances of root complexes which are
exposed on DB820c board. 3 Instances are terminted as below
PCIE0 => QCA6174
PCIE1 => MINI PCIE CARD
PCIE2 => GBE ETHERNET

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 789f3e87321e..18c61693529e 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -138,6 +138,22 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&usb2_vbus_det_gpio>;
 		};
+
+		agnoc at 0 {
+			qcom,pcie at 00600000 {
+				perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+			};
+
+			qcom,pcie at 00608000 {
+				status = "okay";
+				perst-gpio = <&msmgpio 130 GPIO_ACTIVE_LOW>;
+			};
+
+			qcom,pcie at 00610000 {
+				status = "okay";
+				perst-gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
+			};
+		};
 	};
 
 
-- 
2.11.0
