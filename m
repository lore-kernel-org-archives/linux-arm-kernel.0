From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 22 Feb 2014 13:32:35 +0400
Subject: [PATCH 3/3] ARM: dts: imx27-phytec-phycore-som: Add USBOTG node
In-Reply-To: <1393061555-26707-1-git-send-email-shc_work@mail.ru>
References: <1393061555-26707-1-git-send-email-shc_work@mail.ru>
Message-ID: <1393061555-26707-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USBOTG devicetree node of Phytec PCM038 module.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 05b0ecd..cefaa69 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -250,6 +250,23 @@
 				MX27_PAD_NFWE_B__NFWE_B 0x0
 			>;
 		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX27_PAD_USBOTG_CLK__USBOTG_CLK 0x0
+				MX27_PAD_USBOTG_DIR__USBOTG_DIR 0x0
+				MX27_PAD_USBOTG_NXT__USBOTG_NXT 0x0
+				MX27_PAD_USBOTG_STP__USBOTG_STP 0x0
+				MX27_PAD_USBOTG_DATA0__USBOTG_DATA0 0x0
+				MX27_PAD_USBOTG_DATA1__USBOTG_DATA1 0x0
+				MX27_PAD_USBOTG_DATA2__USBOTG_DATA2 0x0
+				MX27_PAD_USBOTG_DATA3__USBOTG_DATA3 0x0
+				MX27_PAD_USBOTG_DATA4__USBOTG_DATA4 0x0
+				MX27_PAD_USBOTG_DATA5__USBOTG_DATA5 0x0
+				MX27_PAD_USBOTG_DATA6__USBOTG_DATA6 0x0
+				MX27_PAD_USBOTG_DATA7__USBOTG_DATA7 0x0
+			>;
+		};
 	};
 };
 
@@ -262,6 +279,19 @@
 	status = "okay";
 };
 
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	dr_mode = "otg";
+	phy_type = "ulpi";
+	vbus-supply = <&sw3_reg>;
+	status = "okay";
+};
+
+&usbphy0 {
+	vcc-supply = <&sw3_reg>;
+};
+
 &weim {
 	status = "okay";
 
-- 
1.8.3.2
