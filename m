From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Apr 2016 10:33:58 +0100
Subject: [PATCH v2 09/13] ARM: dts: db600c: add on board sata support.
In-Reply-To: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1460453642-5809-10-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables sata and regulators required to get on board sata
working.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
index 4f2218c..6f97ddc 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
@@ -123,6 +123,10 @@
 				lvs6 {
 					bias-pull-down;
 				};
+
+				lvs7 {
+					bias-pull-down;
+				};
 			};
 		};
 
@@ -159,6 +163,15 @@
 			perst-gpio = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
 		};
 
+		phy at 1b400000 {
+			status = "okay";
+		};
+
+		sata at 29000000 {
+			status	= "okay";
+			target-supply	= <&pm8921_lvs7>;
+		};
+
 		/* OTG */
 		phy at 12500000 {
 			status		= "okay";
-- 
2.5.0
