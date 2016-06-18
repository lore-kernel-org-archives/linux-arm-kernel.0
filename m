From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 18 Jun 2016 20:09:12 +0300
Subject: [PATCH 2/2] ARM: dts: imx27-phytec-phycore-som: Move AUDMUX pins
 under AUDMUX node
In-Reply-To: <1466269752-8548-1-git-send-email-shc_work@mail.ru>
References: <1466269752-8548-1-git-send-email-shc_work@mail.ru>
Message-ID: <1466269752-8548-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AUDMUX node should be used for the AUDMUX corresponding pins.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 9908b42..f19d1f5b 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -58,6 +58,8 @@
 };
 
 &audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
 	status = "okay";
 
 	/* SSI0 <=> PINS_4 (MC13783 Audio) */
@@ -213,6 +215,15 @@
 
 &iomuxc {
 	imx27_phycore_som {
+		pinctrl_audmux: audmuxgrp {
+			fsl,pins = <
+				MX27_PAD_SSI1_FS__SSI1_FS		0x0
+				MX27_PAD_SSI1_RXDAT__SSI1_RXDAT		0x0
+				MX27_PAD_SSI1_TXDAT__SSI1_TXDAT		0x0
+				MX27_PAD_SSI1_CLK__SSI1_CLK		0x0
+			>;
+		};
+
 		pinctrl_cspi1: cspi1grp {
 			fsl,pins = <
 				MX27_PAD_CSPI1_MISO__CSPI1_MISO 0x0
@@ -271,15 +282,6 @@
 			>;
 		};
 
-		pinctrl_ssi1: ssi1grp {
-			fsl,pins = <
-				MX27_PAD_SSI1_FS__SSI1_FS 0x0
-				MX27_PAD_SSI1_RXDAT__SSI1_RXDAT 0x0
-				MX27_PAD_SSI1_TXDAT__SSI1_TXDAT 0x0
-				MX27_PAD_SSI1_CLK__SSI1_CLK 0x0
-			>;
-		};
-
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
 				MX27_PAD_USBOTG_CLK__USBOTG_CLK 0x0
@@ -309,8 +311,6 @@
 };
 
 &ssi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ssi1>;
 	status = "okay";
 };
 
-- 
2.4.9
