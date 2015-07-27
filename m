From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 27 Jul 2015 14:52:19 +0100
Subject: [PATCH v1 7/7] ARM: dts: apq8064: fix missing gsbi cell-index
In-Reply-To: <1438004945-16175-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438004945-16175-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1438005139-16562-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this i2c instance for missing cell-index nodes would fail, fix
it by adding correct cell-index.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index b7c282b..d2e94d6 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -249,6 +249,7 @@
 		gsbi3: gsbi at 16200000 {
 			status = "disabled";
 			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <3>;
 			reg = <0x16200000 0x100>;
 			clocks = <&gcc GSBI3_H_CLK>;
 			clock-names = "iface";
-- 
1.9.1
