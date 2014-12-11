From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 11 Dec 2014 10:54:33 +0800
Subject: [PATCH] ARM: at91/dt: sama5d4: fix the timer reg length
Message-ID: <1418266473-30187-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second property of reg is the length, so correct it for timer.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 2cc3cfe..0901706 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -940,7 +940,7 @@
 
 			pit: timer at fc068630 {
 				compatible = "atmel,at91sam9260-pit";
-				reg = <0xfc068630 0xf>;
+				reg = <0xfc068630 0x10>;
 				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 5>;
 				clocks = <&h32ck>;
 			};
-- 
2.1.0.24.g4109c28
