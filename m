From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Mon, 20 Apr 2015 10:45:40 +0300
Subject: [PATCH v2 6/7] arm64: dts: qcom: Add MSM8916 restart device node
In-Reply-To: <1429515941-15334-1-git-send-email-ivan.ivanov@linaro.org>
References: <1429515941-15334-1-git-send-email-ivan.ivanov@linaro.org>
Message-ID: <1429515941-15334-7-git-send-email-ivan.ivanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the restart node so we can reboot the device.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 92c96eb..7887588 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -77,6 +77,11 @@
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";

+		restart at 4ab000 {
+			compatible = "qcom,pshold";
+			reg = <0x4ab000 0x4>;
+		};
+
 		pinctrl at 1000000 {
 			compatible = "qcom,msm8916-pinctrl";
 			reg = <0x1000000 0x300000>;
--
1.9.1
