From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 May 2014 09:20:14 +0100
Subject: [PATCH 2/3] ARM: sti: stih416: Enable board LED support for B2020 RevE
In-Reply-To: <1400660415-14720-1-git-send-email-lee.jones@linaro.org>
References: <1400660415-14720-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1400660415-14720-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two LEDs available on the B2020 RevE board, one red, one
green.  In this patch we enable the red one for "heartbeat" and turn
the green one off.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416-b2020-revE.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-b2020-revE.dts b/arch/arm/boot/dts/stih416-b2020-revE.dts
index 202919a..0a33739 100644
--- a/arch/arm/boot/dts/stih416-b2020-revE.dts
+++ b/arch/arm/boot/dts/stih416-b2020-revE.dts
@@ -14,6 +14,20 @@
 	compatible = "st,stih416-b2020", "st,stih416";
 
 	soc {
+		leds {
+			compatible = "gpio-leds";
+			red {
+				#gpio-cells		= <1>;
+				label			= "Front Panel LED";
+				gpios			= <&PIO4 1>;
+				linux,default-trigger	= "heartbeat";
+			};
+			green {
+				gpios			= <&PIO1 3>;
+				default-state 		= "off";
+			};
+		};
+
 		ethernet1: ethernet at fef08000 {
 			snps,reset-gpio = <&PIO0 7>;
 		};
-- 
1.8.3.2
