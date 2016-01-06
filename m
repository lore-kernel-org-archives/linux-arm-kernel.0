From: vinaysimha@inforcecomputing.com (Vinay Simha BN)
Date: Wed,  6 Jan 2016 12:12:24 +0530
Subject: [PATCH] arm64: dts: qcom: apq8016-sbc: leds: bt and wlan
Message-ID: <1452062554-4167-1-git-send-email-vinaysimha@inforcecomputing.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BT LED   - PMIC - MPP_03
WLAN LED - PMIC - MPP_02

Signed-off-by: Vinay Simha BN <vinaysimha@inforcecomputing.com>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 7bb0ab8..37ca0c8 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -94,14 +94,14 @@
 		led at 5 {
 			label = "apq8016-sbc:yellow:wifi";
 			gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "wlan";
+			linux,default-trigger = "rfkill0";
 			default-state = "off";
 		};
 
 		led at 6 {
 			label = "apq8016-sbc:blue:bt";
 			gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "bt";
+			linux,default-trigger = "rfkill1";
 			default-state = "off";
 		};
 	};
-- 
2.1.2
