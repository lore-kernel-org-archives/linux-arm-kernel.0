From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 18 Sep 2015 13:31:47 +0100
Subject: [PATCH 09/14] ARM: dts: ifc6410: Add missing pinctrl to gsbi7 uart
In-Reply-To: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1442579507-20314-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing 2pin uart pinctrl property to gsbi7 uart on
IFC6410.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 56eaf5a..c1d5bd7 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -154,6 +154,8 @@
 			qcom,mode = <GSBI_PROT_I2C_UART>;
 			serial at 16640000 {
 				status = "ok";
+				pinctrl-names = "default";
+				pinctrl-0 = <&gsbi7_uart_2pins>;
 			};
 		};
 
-- 
1.9.1
