From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 10 Feb 2015 09:55:34 +0800
Subject: [PATCH v2 1/2] ARM: at91: dt: at91sam9n12: add udp device node
In-Reply-To: <1423533335-25135-1-git-send-email-voice.shen@atmel.com>
References: <1423533335-25135-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1423533335-25135-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb device node for at91sam9n12.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

Changes in v2: None

 arch/arm/boot/dts/at91sam9n12.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index c2666a7..e1b6f0b 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -913,6 +913,15 @@
 				clocks = <&pwm_clk>;
 				status = "disabled";
 			};
+
+			usb1: gadget at f803c000 {
+				compatible = "atmel,at91sam9260-udc";
+				reg = <0xf803c000 0x4000>;
+				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
+				clocks = <&udphs_clk>, <&udpck>;
+				clock-names = "pclk", "hclk";
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
2.3.0.rc0
