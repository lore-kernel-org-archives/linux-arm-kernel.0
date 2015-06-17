From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 18 Jun 2015 02:05:37 +0800
Subject: [PATCH 6/6] dts: mmc: fsl-imx-esdhc: remove fsl, cd-controller support
In-Reply-To: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1434564337-24720-7-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not supported by driver anymore after using runtime pm
and there's no user of it, so delete it now.

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 5d0376b..211e778 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -17,7 +17,6 @@ Required properties:
 	       "fsl,imx6sx-usdhc"
 
 Optional properties:
-- fsl,cd-controller : Indicate to use controller internal card detection
 - fsl,wp-controller : Indicate to use controller internal write protection
 - fsl,delay-line : Specify the number of delay cells for override mode.
   This is used to set the clock delay for DLL(Delay Line) on override mode
@@ -35,7 +34,6 @@ esdhc at 70004000 {
 	compatible = "fsl,imx51-esdhc";
 	reg = <0x70004000 0x4000>;
 	interrupts = <1>;
-	fsl,cd-controller;
 	fsl,wp-controller;
 };
 
-- 
1.9.1
