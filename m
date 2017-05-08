From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon,  8 May 2017 18:21:12 +0200
Subject: [PATCH 3/8] mfd: dts: hi655x: Add clock binding for the pmic
In-Reply-To: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1494260477-25163-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The hi655x PMIC provides the regulators but also a clock. The latter is
missing in the definition, so extend the documentation to include this as
well.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
[Ulf: Split patch and updated changelog]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt b/Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt
index 0548569..9630ac0 100644
--- a/Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt
+++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt
@@ -16,6 +16,11 @@ Required properties:
 - reg:                  Base address of PMIC on Hi6220 SoC.
 - interrupt-controller: Hi655x has internal IRQs (has own IRQ domain).
 - pmic-gpios:           The GPIO used by PMIC IRQ.
+- #clock-cells:		From common clock binding; shall be set to 0
+
+Optional properties:
+- clock-output-names: From common clock binding to override the
+  default output clock name
 
 Example:
 	pmic: pmic at f8000000 {
@@ -24,4 +29,5 @@ Example:
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		pmic-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		#clock-cells = <0>;
 	}
-- 
2.7.4
