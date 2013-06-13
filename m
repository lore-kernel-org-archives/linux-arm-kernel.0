From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jun 2013 15:43:42 +0200
Subject: [PATCH 1/4] ARM: cfa10036: Add USB0 OTG port
In-Reply-To: <1371131025-12200-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1371131025-12200-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1371131025-12200-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10036.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index 1594694..eae9c97 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -45,6 +45,17 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				usb0_otg_cfa10036: otg-10036 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x0142 /* MX28_PAD_GPMI_READY0__USB0_ID */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 			};
 
 			ssp0: ssp at 80010000 {
@@ -82,6 +93,18 @@
 					reset-gpios = <&gpio2 7 0>;
 				};
 			};
+
+			usbphy0: usbphy at 8007c000 {
+				status = "okay";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		usb0: usb at 80080000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb0_otg_cfa10036>;
+			status = "okay";
 		};
 	};
 
-- 
1.8.3
