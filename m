From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 24 May 2017 10:28:23 +0200
Subject: [PATCH 3/5] ARM64: dts: meson-gxl: Add Ethernet PHY LEDS pins nodes
In-Reply-To: <1495614505-4437-1-git-send-email-narmstrong@baylibre.com>
References: <1495614505-4437-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495614505-4437-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GXL SoCs embeds an 10/100 Ethernet PHY, this patchs adds
the Link and Activity LEDs signals pins nodes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 478d3b4..300dfad 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -404,6 +404,20 @@
 			};
 		};
 
+		eth_link_led_pins: eth_link_led {
+			mux {
+				groups = "eth_link_led";
+				function = "eth_led";
+			};
+		};
+
+		eth_act_led_pins: eth_act_led {
+			mux {
+				groups = "eth_act_led";
+				function = "eth_led";
+			};
+		};
+		
 		pwm_a_pins: pwm_a {
 			mux {
 				groups = "pwm_a";
-- 
1.9.1
