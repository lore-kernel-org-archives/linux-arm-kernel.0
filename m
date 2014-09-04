From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 4 Sep 2014 14:22:55 -0300
Subject: [PATCH 2/6] ARM: dts: imx28-apf28dev: Fix display duplicate name
 warning
In-Reply-To: <1409851379-5330-1-git-send-email-fabio.estevam@freescale.com>
References: <1409851379-5330-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1409851379-5330-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lcdif node has a property named "display" and also a child node
called "display", which causes the following warning:

device-tree: Duplicate name in lcdif at 80030000, renamed to "display#1"

Rename the child node name in order to avoid the wa

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-apf28dev.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 221cac4..1f38a05 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -83,10 +83,10 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_16bit_pins_a
 						&lcdif_pins_apf28dev>;
-				display = <&display>;
+				display = <&display0>;
 				status = "okay";
 
-				display: display {
+				display0: display0 {
 					bits-per-pixel = <16>;
 					bus-width = <16>;
 
-- 
1.9.1
