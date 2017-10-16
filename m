From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Oct 2017 16:26:07 +0200
Subject: [PATCH] ARM: dts: fix PCLK name on Gemini and MOXA ART
Message-ID: <20171016142607.11930-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These platforms provide a clock to their watchdog, in each
case this is the peripheral clock (PCLK), so explicitly
name the clock in the device tree.

Take this opportunity to add the "faraday,ftwdt010"
compatible as fallback to the watchdog IP blocks.

Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for DTS.
---
 arch/arm/boot/dts/gemini.dtsi | 3 ++-
 arch/arm/boot/dts/moxart.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index c68e8d430234..f0d178c77153 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -145,11 +145,12 @@
 		};
 
 		watchdog at 41000000 {
-			compatible = "cortina,gemini-watchdog";
+			compatible = "cortina,gemini-watchdog", "faraday,ftwdt010";
 			reg = <0x41000000 0x1000>;
 			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&syscon GEMINI_RESET_WDOG>;
 			clocks = <&syscon GEMINI_CLK_APB>;
+			clock-names = "PCLK";
 		};
 
 		uart0: serial at 42000000 {
diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxart.dtsi
index 1f4c795d3f72..da7b3237bfe9 100644
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -87,9 +87,10 @@
 		};
 
 		watchdog: watchdog at 98500000 {
-			compatible = "moxa,moxart-watchdog";
+			compatible = "moxa,moxart-watchdog", "faraday,ftwdt010";
 			reg = <0x98500000 0x10>;
 			clocks = <&clk_apb>;
+			clock-names = "PCLK";
 		};
 
 		sdhci: sdhci at 98e00000 {
-- 
2.13.6
