From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Nov 2018 11:58:00 +0100
Subject: [PATCH] ARM: dts: msm8660: Mark two GSBI blocks "disabled"
Message-ID: <20181129105800.13284-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GSBI module complains:

gsbi 16500000.gsbi: missing mode configuration
gsbi: probe of 16500000.gsbi failed with error -22
gsbi 16600000.gsbi: missing mode configuration
gsbi: probe of 16600000.gsbi failed with error -22
gsbi 19800000.gsbi: GSBI port protocol: 2 crci: 0

So we should mark these GSBIs as "disabled" in the SoC
file by default.

If boards appear that make use of them, we can simply
set status = "ok" in the DTS for them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 70698941f64c..9b1cf00d8ca3 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -133,6 +133,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			status = "disabled";
 
 			syscon-tcsr = <&tcsr>;
 
@@ -167,6 +168,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			status = "disabled";
 
 			syscon-tcsr = <&tcsr>;
 
-- 
2.19.1
