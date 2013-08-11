From: luka@openwrt.org (Luka Perkov)
Date: Sun, 11 Aug 2013 17:04:00 +0200
Subject: [PATCH] ARM: dts: imx6sl/imx6qdl: use the same SDMA firmware
Message-ID: <1376233440-30067-1-git-send-email-luka@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch for SDMA firmware sent by Fabio Estevam in January [1] didn't make
upstream. Nonetheless, it was pointed out that all imx6 use the same SDMA
firmware [2]. Reflect this fact in appropriate .dtsi files.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/143025.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/143150.html

Signed-off-by: Luka Perkov <luka@openwrt.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 arch/arm/boot/dts/imx6sl.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index f21d259..267d080 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -582,7 +582,7 @@
 				interrupts = <0 2 0x04>;
 				clocks = <&clks 155>, <&clks 155>;
 				clock-names = "ipg", "ahb";
-				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6.bin";
 			};
 		};
 
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c5e5da0..9596000 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -594,7 +594,7 @@
 				clocks = <&clks IMX6SL_CLK_SDMA>,
 					 <&clks IMX6SL_CLK_SDMA>;
 				clock-names = "ipg", "ahb";
-				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6sl.bin";
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6.bin";
 			};
 
 			pxp: pxp at 020f0000 {
-- 
1.8.3.4
