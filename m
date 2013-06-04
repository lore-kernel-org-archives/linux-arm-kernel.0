From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue,  4 Jun 2013 13:07:10 +0200
Subject: [PATCH 3/8] ARM i.MX53: mba53: add Tevision Encoder
In-Reply-To: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1370344035-7417-4-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Enable tve on MBa53.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53-mba53.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 6fa9a09..2889bab 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -106,6 +106,16 @@
 			>;
 		};
 	};
+
+	tve {
+		pinctrl_vga_sync_1: vgasync-grp1 {
+			fsl,pins = <
+				/* VGA_VSYNC, HSYNC with max drive strength */
+				MX53_PAD_EIM_CS1__IPU_DI1_PIN6	   0xe6
+				MX53_PAD_EIM_DA15__IPU_DI1_PIN4	   0xe6
+			>;
+		};
+	};
 };
 
 &cspi {
@@ -174,3 +184,13 @@
 &i2c3 {
 	status = "okay";
 };
+
+&tve {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_vga_sync_1>;
+	ddc = <&i2c3>;
+	fsl,tve-mode = "vga";
+	fsl,hsync-pin = <4>;
+	fsl,vsync-pin = <6>;
+	status = "okay";
+};
-- 
1.8.2.rc2
