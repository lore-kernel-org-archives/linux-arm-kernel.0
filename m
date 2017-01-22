From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 23:39:43 +0100
Subject: [PATCH 3/3] ARM: dts: add watchdog to the Gemini
Message-ID: <20170122223943.29380-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds watchdog support to the Gemini SoC DTSI file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This pach is FYI only, I will carry this to the ARM SoC tree.
---
 arch/arm/boot/dts/gemini.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 19c93cfbeae3..405d6cedf409 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -33,6 +33,12 @@
 		};
 	};
 
+	watchdog at 41000000 {
+		compatible = "cortina,gemini-watchdog";
+		reg = <0x41000000 0x1000>;
+		interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	timer at 43000000 {
 		compatible = "cortina,gemini-timer";
 		reg = <0x43000000 0x1000>;
-- 
2.9.3
