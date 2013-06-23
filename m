From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 23 Jun 2013 10:44:17 +0200
Subject: [PATCH v2 1/5] ARM: imx27: Use 'AITC' for the interrupt controller
 name
In-Reply-To: <1371977061-9891-1-git-send-email-mpa@pengutronix.de>
References: <1371977061-9891-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1371977061-9891-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

On the MX27 Reference Manual the interrupt controller is named AITC:
ARM926EJ-S Interrupt Controller

So use the AITC term instead of AVIC.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Origin: id:1334193132-18944-2-git-send-email-festevam at gmail.com
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 0695264..8603886 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -30,8 +30,8 @@
 		spi2 = &cspi3;
 	};
 
-	avic: avic-interrupt-controller at e0000000 {
-		compatible = "fsl,imx27-avic", "fsl,avic";
+	aitc: aitc-interrupt-controller at e0000000 {
+		compatible = "fsl,imx27-aitc", "fsl,avic";
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		reg = <0x10040000 0x1000>;
@@ -51,7 +51,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-		interrupt-parent = <&avic>;
+		interrupt-parent = <&aitc>;
 		ranges;
 
 		aipi at 10000000 { /* AIPI1 */
-- 
1.8.2.1
