From: chunkeey@gmail.com (Christian Lamparter)
Date: Mon, 28 May 2018 13:06:02 +0200
Subject: [PATCH v6 2/2] ARM: dts: qcom: add gpio-ranges property
In-Reply-To: <6dbaadee4bb22638a2c2e6433e8d1740884ecfd9.1527505307.git.chunkeey@gmail.com>
References: <6dbaadee4bb22638a2c2e6433e8d1740884ecfd9.1527505307.git.chunkeey@gmail.com>
Message-ID: <568b9fc98e8540a58ba165ea0ce1563daf292af7.1527505307.git.chunkeey@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the gpio-ranges property to almost all of
the Qualcomm ARM platforms that utilize the pinctrl-msm
framework.

The gpio-ranges property is part of the gpiolib subsystem.
As a result, the binding text is available in section
"2.1 gpio- and pin-controller interaction" of
Documentation/devicetree/bindings/gpio/gpio.txt

For more information please see the patch titled:
"pinctrl: msm: fix gpio-hog related boot issues" from
this series.

Reported-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
Tested-by: Sven Eckelmann <sven.eckelmann@openmesh.com> [ipq4019]
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
Apart from the added "Reviewed-by", this patch is unchanged from v5.
I included it to preserve the context of the updated patch:
"dt-bindings: pinctrl: qcom: add gpio-ranges, gpio-reserved-ranges"
in this series.

As for the other two patches: Linus has already applied them so I
dropped them from the series. :)
---
 arch/arm/boot/dts/qcom-apq8064.dtsi   | 1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi   | 1 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi   | 1 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi   | 1 +
 arch/arm/boot/dts/qcom-mdm9615.dtsi   | 1 +
 arch/arm/boot/dts/qcom-msm8660.dtsi   | 1 +
 arch/arm/boot/dts/qcom-msm8960.dtsi   | 1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi   | 1 +
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 3 ++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 arch/arm64/boot/dts/qcom/msm8992.dtsi | 1 +
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 1 +
 13 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 5341a39c0392..4001eeb52f20 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -344,6 +344,7 @@
 			reg = <0x800000 0x4000>;
 
 			gpio-controller;
+			gpio-ranges = <&tlmm_pinmux 0 0 90>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 0e1e98707e3f..d9481d083802 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -396,6 +396,7 @@
 			compatible = "qcom,apq8084-pinctrl";
 			reg = <0xfd510000 0x4000>;
 			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 147>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 10d112a4078e..9a81d2da87a0 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -146,6 +146,7 @@
 			compatible = "qcom,ipq4019-pinctrl";
 			reg = <0x01000000 0x300000>;
 			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 100>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 1e0a3b446f7a..26eab9a68d90 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -108,6 +108,7 @@
 			reg = <0x800000 0x4000>;
 
 			gpio-controller;
+			gpio-ranges = <&qcom_pinmux 0 0 69>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index c852b69229c9..cfdaca5f259a 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -128,6 +128,7 @@
 		msmgpio: pinctrl at 800000 {
 			compatible = "qcom,mdm9615-pinctrl";
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 88>;
 			#gpio-cells = <2>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 33030f9419fe..47cf9c4ca062 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -110,6 +110,7 @@
 			reg = <0x800000 0x4000>;
 
 			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 173>;
 			#gpio-cells = <2>;
 			interrupts = <0 16 0x4>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 1733d8f40ab1..f6d8b1af5a8a 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -102,6 +102,7 @@
 		msmgpio: pinctrl at 800000 {
 			compatible = "qcom,msm8960-pinctrl";
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 152>;
 			#gpio-cells = <2>;
 			interrupts = <0 16 0x4>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d9019a49b292..1250e071a6e2 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -696,6 +696,7 @@
 			compatible = "qcom,msm8974-pinctrl";
 			reg = <0xfd510000 0x4000>;
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 146>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 2bc5dec5614d..d2c36b467466 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -24,11 +24,12 @@
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
-		pinctrl at 1000000 {
+		tlmm: pinctrl at 1000000 {
 			compatible = "qcom,ipq8074-pinctrl";
 			reg = <0x1000000 0x300000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 70>;
 			#gpio-cells = <0x2>;
 			interrupt-controller;
 			#interrupt-cells = <0x2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 66b318e1de80..9d5320b26188 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -326,6 +326,7 @@
 			reg = <0x1000000 0x300000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 122>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 171578747ed0..173b6bc60816 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -179,6 +179,7 @@
 			reg = <0xfd510000 0x4000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 146>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index f33c41d01c86..68705db4696b 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -141,6 +141,7 @@
 			reg = <0xfd510000 0x4000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 146>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 410ae787ebb4..b9b57808fc67 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -541,6 +541,7 @@
 			reg = <0x01010000 0x300000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 150>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-- 
2.17.0
