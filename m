From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 11 Jul 2014 18:22:55 +0800
Subject: [PATCH] ARM: at91: at91sam9x5: add clocks for usb device
Message-ID: <1405074175-22444-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clocks for usb device, or else switch to CCF, the gadget
won't work.

Reported-by: Ji?? Prchal <jiri.prchal@aksignal.cz>
Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index d6133f4..2ebc421 100644
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
1.8.5.2
