From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Jan 2017 20:36:35 +0100
Subject: [PATCH 4/4] ARM: dts: add power controller to the Gemini DTS
In-Reply-To: <20170130193635.18644-1-linus.walleij@linaro.org>
References: <20170130193635.18644-1-linus.walleij@linaro.org>
Message-ID: <20170130193635.18644-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Gemini power controller to the SoC DTSI
file.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Sebastian: this patch is just for context.
I will funnel the ARM parts through the ARM SoC tree.
---
 arch/arm/boot/dts/gemini.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index df5630958038..8a2501239ae5 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -70,6 +70,12 @@
 		#interrupt-cells = <2>;
 	};
 
+	power-controller at 4b000000 {
+		compatible = "cortina,gemini-power-controller";
+		reg = <0x4b000000 0x100>;
+		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+	};
+
 	gpio0: gpio at 4d000000 {
 		compatible = "cortina,gemini-gpio";
 		reg = <0x4d000000 0x100>;
-- 
2.9.3
