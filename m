From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 11 Jul 2014 18:34:56 +0200
Subject: [PATCH] ARM: at91: at91sam9x5: add clocks for usb device
Message-ID: <1405096496-4139-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bo Shen <voice.shen@atmel.com>

Add clocks for usb device, or else switch to CCF, the gadget
won't work.

Reported-by: Jiri Prchal <jiri.prchal@aksignal.cz>
Signed-off-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Tested-by: Jiri Prchal <jiri.prchal@aksignal.cz>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Arnd, Olof, Kevin,

This fix is the only one that I have for 3.16-rc currently. Can you please
take it as a patch and queue it? It can go on top of already sent AT91 fixes
for 3.16 or a 3.16-rc4.

Best regards,

 arch/arm/boot/dts/at91sam9x5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index d6133f497207..2ebc42140ea6 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -1045,6 +1045,8 @@
 				reg = <0x00500000 0x80000
 				       0xf803c000 0x400>;
 				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&usb>, <&udphs_clk>;
+				clock-names = "hclk", "pclk";
 				status = "disabled";
 
 				ep0 {
-- 
1.8.2.2
