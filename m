From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 9 Feb 2015 17:02:51 +0800
Subject: [PATCH 2/3] ARM: at91: dt: at91sam9n12: add udp device node
In-Reply-To: <1423472572-19824-1-git-send-email-voice.shen@atmel.com>
References: <1423472572-19824-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1423472572-19824-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb device node for at91sam9n12.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/at91sam9n12.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 68eb9ad..6120e03 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -901,6 +901,15 @@
 				clocks = <&pwm_clk>;
 				status = "disabled";
 			};
+
+			usb1: gadget at f803c000 {
+				compatible = "atmel,at91rm9200-udc";
+				reg = <0xf803c000 0x4000>;
+				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
+				clocks = <&usb>, <&udphs_clk>, <&udpck>;
+				clock-names = "usb_clk", "udc_clk", "udpck";
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
2.3.0.rc0
