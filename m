From: xobs@kosagi.com (Sean Cross)
Date: Wed,  6 Mar 2013 05:05:31 +0000
Subject: [PATCH 1/2] imx6q: Add ECSPI3 device definition
In-Reply-To: <1362546332-11847-1-git-send-email-xobs@kosagi.com>
References: <1362546332-11847-1-git-send-email-xobs@kosagi.com>
Message-ID: <1362546332-11847-2-git-send-email-xobs@kosagi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree support for the ECSPI3 device.
---
 arch/arm/boot/dts/imx6q.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index cba021e..65b3a849 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -96,6 +96,16 @@
 					};
 				};
 
+				ecspi3 {
+					pinctrl_ecspi3_1: ecspi3grp-1 {
+						fsl,pins = <
+							526 0x100b1	/* MX6Q_PAD_DISP0_DAT2__ECSPI3_MISO */
+							518 0x100b1	/* MX6Q_PAD_DISP0_DAT1__ECSPI3_MOSI */
+							511 0x100b1	/* MX6Q_PAD_DISP0_DAT0__ECSPI3_SCLK */
+						>;
+					};
+				};
+
 				enet {
 					pinctrl_enet_1: enetgrp-1 {
 						fsl,pins = <
-- 
1.7.9.5
