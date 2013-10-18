From: b32955@freescale.com (Huang Shijie)
Date: Fri, 18 Oct 2013 10:32:52 +0800
Subject: [PATCH 1/2] ARM: dts: imx6sl: add a pinctrl for ECSPI1
Message-ID: <1382063573-21326-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a pinctrl for ECSPI1. This pinctrl can be used in the imx6sl-evk board.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6sl.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 17607b3..1f3c379 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -543,6 +543,16 @@
 				compatible = "fsl,imx6sl-iomuxc";
 				reg = <0x020e0000 0x4000>;
 
+				ecspi1 {
+					pinctrl_ecspi1_1: ecspi1grp-1 {
+						fsl,pins = <
+							MX6SL_PAD_ECSPI1_MISO__ECSPI1_MISO 0x100b1
+							MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI 0x100b1
+							MX6SL_PAD_ECSPI1_SCLK__ECSPI1_SCLK 0x100b1
+						>;
+					};
+				};
+
 				fec {
 					pinctrl_fec_1: fecgrp-1 {
 						fsl,pins = <
-- 
1.7.2.rc3
