From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 31 May 2016 16:31:50 +0200
Subject: [PATCH 1/3] ARM: dts: imx28: Use generic uart-has-rtscts DT property
In-Reply-To: <1464705112-21609-1-git-send-email-geert+renesas@glider.be>
References: <1464705112-21609-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1464705112-21609-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 182cdcb8bb16e687 ("serial: mxs-auart: Use generic
uart-has-rtscts DT property"), the Freescale MXS AUART driver recognizes
the generic "uart-has-rtscts" DT property, deprecating the
vendor-specific "fsl,uart-has-rtscts" DT property. Hence replace the
latter by the former in all DTS files.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/imx28-apf28dev.dts | 2 +-
 arch/arm/boot/dts/imx28-evk.dts      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 1eaa131e2d1809fb..c4fadbc1b40040f4 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -140,7 +140,7 @@
 			auart0: serial at 8006a000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&auart0_pins_a>;
-				fsl,uart-has-rtscts;
+				uart-has-rtscts;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index e3ef94ac159f75b2..a5ba669b4eaa4ce3 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -224,7 +224,7 @@
 			auart0: serial at 8006a000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&auart0_pins_a>;
-				fsl,uart-has-rtscts;
+				uart-has-rtscts;
 				status = "okay";
 			};
 
-- 
1.9.1
