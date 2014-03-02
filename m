From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  2 Mar 2014 13:18:39 +0400
Subject: [PATCH 2/2] ARM: dts: imx27-phytec-phycore-som: Enable SSI1
In-Reply-To: <1393751919-17892-1-git-send-email-shc_work@mail.ru>
References: <1393751919-17892-1-git-send-email-shc_work@mail.ru>
Message-ID: <1393751919-17892-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pin group for Synchronous Serial Interface 1 (SSI1)
for PCM-038 module and enables this interface. This change do nothing
at the current stage but helps to continue develop sound support.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index cefaa69..8e10aef 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -251,6 +251,15 @@
 			>;
 		};
 
+		pinctrl_ssi1: ssi1grp {
+			fsl,pins = <
+				MX27_PAD_SSI1_FS__SSI1_FS 0x0
+				MX27_PAD_SSI1_RXDAT__SSI1_RXDAT 0x0
+				MX27_PAD_SSI1_TXDAT__SSI1_TXDAT 0x0
+				MX27_PAD_SSI1_CLK__SSI1_CLK 0x0
+			>;
+		};
+
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
 				MX27_PAD_USBOTG_CLK__USBOTG_CLK 0x0
@@ -279,6 +288,13 @@
 	status = "okay";
 };
 
+&ssi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ssi1>;
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
 &usbotg {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbotg>;
-- 
1.8.3.2
