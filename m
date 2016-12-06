From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue,  6 Dec 2016 16:08:38 +0800
Subject: [PATCH] ARM: dts: sun8i-q8-common: enable bluetooth on SDIO Wi-Fi
Message-ID: <20161206080838.7523-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SDIO Wi-Fi chips (such as RTL8703AS) have a UART bluetooth, which
has a dedicated enable pin (PL8 in the reference design).

Enable the pin in the same way as the WLAN enable pins.

Tested on an A33 Q8 tablet with RTL8703AS.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---

This patch should be coupled with the uart1 node patch I send before:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/471997.html

For RTL8703AS, the rtl8723bs bluetooth code is used, which can be retrieve from:
https://github.com/lwfinger/rtl8723bs_bt

 arch/arm/boot/dts/sun8i-q8-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
index c676940..4aeb5bb 100644
--- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
@@ -88,7 +88,7 @@
 
 &r_pio {
 	wifi_pwrseq_pin_q8: wifi_pwrseq_pin at 0 {
-		pins = "PL6", "PL7", "PL11";
+		pins = "PL6", "PL7", "PL8", "PL11";
 		function = "gpio_in";
 		bias-pull-up;
 	};
-- 
2.10.2
