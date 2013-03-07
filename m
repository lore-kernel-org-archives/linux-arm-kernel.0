From: xobs@kosagi.com (Sean Cross)
Date: Thu,  7 Mar 2013 06:00:08 +0000
Subject: [PATCH v2 1/3] ARM: dts: imx6q: Add pinctrl for ecspi3
In-Reply-To: <1362636010-17367-1-git-send-email-xobs@kosagi.com>
References: <1362636010-17367-1-git-send-email-xobs@kosagi.com>
Message-ID: <1362636010-17367-2-git-send-email-xobs@kosagi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a group of pins to allow ecspi3 to be used on imx6q.
---
 arch/arm/boot/dts/imx6q.dtsip |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsip b/arch/arm/boot/dts/imx6q.dtsip
index 749c5c4..f318678 100644
--- a/arch/arm/boot/dts/imx6q.dtsip
+++ b/arch/arm/boot/dts/imx6q.dtsip
@@ -97,6 +97,16 @@
 					};
 				};
 
+				ecspi3 {
+					pinctrl_ecspi3_1: ecspi3grp-1 {
+						fsl,pins = <
+							MX6Q_PAD_DISP0_DAT2__ECSPI3_MISO 0x100b1
+							MX6Q_PAD_DISP0_DAT1__ECSPI3_MOSI 0x100b1
+							MX6Q_PAD_DISP0_DAT0__ECSPI3_SCLK 0x100b1
+						>;
+					};
+				};
+
 				enet {
 					pinctrl_enet_1: enetgrp-1 {
 						fsl,pins = <
-- 
1.7.9.5
