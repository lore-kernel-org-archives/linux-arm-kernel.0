From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 9 Jul 2014 13:40:26 +0800
Subject: [PATCH] ARM: dts: imx53: correct clock-names of SATA node
Message-ID: <1404884426-28957-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Per the binding doc imx-sata.txt, the first entry of clock-names should
be "sata" than anything else.  Correct it for imx53 SATA node.

It works for now only because SATA driver gets clock by index so far.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/boot/dts/imx53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 5fe8509cc4b6..64fa27b36be0 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -108,7 +108,7 @@
 			clocks = <&clks IMX5_CLK_SATA_GATE>,
 				 <&clks IMX5_CLK_SATA_REF>,
 				 <&clks IMX5_CLK_AHB>;
-			clock-names = "sata_gate", "sata_ref", "ahb";
+			clock-names = "sata", "sata_ref", "ahb";
 			status = "disabled";
 		};
 
-- 
1.8.3.2
