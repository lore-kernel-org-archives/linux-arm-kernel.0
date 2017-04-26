From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 26 Apr 2017 15:04:44 -0700
Subject: [PATCH 2/2] arm64: dts: apq8016-sbc: Correct WLAN LED default-trigger
In-Reply-To: <20170426220444.10539-1-bjorn.andersson@linaro.org>
References: <20170426220444.10539-1-bjorn.andersson@linaro.org>
Message-ID: <20170426220444.10539-2-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TX status trigger of the wlan interface is named phy0tx, so this
updates the default-trigger for the WLAN LED to use that instead.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Note that without patch 1/2 this trigger does not fire - but there's also no
harm in picking the two patches through separate trees.

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 5d83b02b7c4a..21a8f5ce8955 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -178,7 +178,7 @@
 			led at 5 {
 				label = "apq8016-sbc:yellow:wlan";
 				gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
-				linux,default-trigger = "wlan";
+				linux,default-trigger = "phy0tx";
 				default-state = "off";
 			};
 
-- 
2.12.0
