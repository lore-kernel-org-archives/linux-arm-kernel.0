From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 22 Aug 2012 13:25:33 -0300
Subject: [PATCH 3/3] ARM: olinuxino: Add gpio-led support
In-Reply-To: <1345652733-13265-1-git-send-email-festevam@gmail.com>
References: <1345652733-13265-1-git-send-email-festevam@gmail.com>
Message-ID: <1345652733-13265-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Olinuxino has a LED connected to MX23_PAD_SSP1_DETECT__GPIO_2_1 pin.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23-olinuxino.dts |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index a286873..711dcf5 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -31,6 +31,21 @@
 				bus-width = <4>;
 				status = "okay";
 			};
+
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				hog_pins_a: hog at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x2013 /* MX23_PAD_SSP1_DETECT__GPIO_2_1 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
 		};
 
 		apbx at 80040000 {
@@ -47,4 +62,14 @@
 			};
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user {
+			label = "green";
+			gpios = <&gpio2 1 0>;
+			linux,default-trigger = "default-on";
+		};
+	};
 };
-- 
1.7.9.5
