From: b32955@freescale.com (Huang Shijie)
Date: Thu, 9 May 2013 11:29:00 +0800
Subject: [PATCH 2/5] ARM: dts: imx6dl: add a pinctrl for eCSPI1
In-Reply-To: <1368070143-1655-1-git-send-email-b32955@freescale.com>
References: <1368070143-1655-1-git-send-email-b32955@freescale.com>
Message-ID: <1368070143-1655-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 24544ed..4b13454 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -35,6 +35,16 @@
 				compatible = "fsl,imx6dl-iomuxc";
 				reg = <0x020e0000 0x4000>;
 
+				ecspi1 {
+					pinctrl_ecspi1_1: ecspi1grp-1 {
+						fsl,pins = <
+							MX6DL_PAD_EIM_D17__ECSPI1_MISO 0x100b1
+							MX6DL_PAD_EIM_D18__ECSPI1_MOSI 0x100b1
+							MX6DL_PAD_EIM_D16__ECSPI1_SCLK 0x100b1
+						>;
+					};
+				};
+
 				enet {
 					pinctrl_enet_1: enetgrp-1 {
 						fsl,pins = <
-- 
1.7.1
