From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 22 Feb 2017 15:01:47 +0100
Subject: [PATCH v2 2/4] ARM: dts: da850: add vpif video display pins
In-Reply-To: <1487772109-10014-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487772109-10014-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1487772109-10014-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new pinctrl sub-node for vpif display pins. Move VP_CLKIN3 and
VP_CLKIN2 to the display node where they actually belong (vide section
36.2.2 of the OMAP-L138 technical reference manual).

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 92d633d..5150331 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -216,8 +216,21 @@
 					0x3c 0x11111111 0xffffffff
 					/* VP_DIN[8..9] */
 					0x40 0x00000011 0x000000ff
-					/* VP_CLKIN3, VP_CLKIN2 */
-					0x4c 0x00010100 0x000f0f00
+				>;
+			};
+			vpif_display_pins: vpif_display_pins {
+				pinctrl-single,bits = <
+					/* VP_DOUT[2..7] */
+					0x40 0x11111100 0xffffff00
+					/* VP_DOUT[10..15,0..1] */
+					0x44 0x11111111 0xffffffff
+					/*  VP_DOUT[8..9] */
+					0x48 0x00000011 0x000000ff
+					/*
+					 * VP_CLKOUT3, VP_CLKIN3,
+					 * VP_CLKOUT2, VP_CLKIN2
+					 */
+					0x4c 0x00111100 0x00ffff00
 				>;
 			};
 		};
-- 
2.9.3
