From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  4 Sep 2014 22:31:23 -0300
Subject: [PATCH v2 6/6] ARM: dts: imx28-m28evk: Fix display duplicate name
 warning
In-Reply-To: <1409880683-27402-1-git-send-email-festevam@gmail.com>
References: <1409880683-27402-1-git-send-email-festevam@gmail.com>
Message-ID: <1409880683-27402-6-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The lcdif node has a property named "display" and also a child node
called "display", which causes the following warning:

device-tree: Duplicate name in lcdif at 80030000, renamed to "display#1"

Rename the child node name in order to avoid the warning.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/imx28-m28evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index b3c09ae..e35cc6b 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -81,10 +81,10 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a
 					     &lcdif_pins_m28>;
-				display = <&display>;
+				display = <&display0>;
 				status = "okay";
 
-				display: display {
+				display0: display0 {
 					bits-per-pixel = <16>;
 					bus-width = <18>;
 
-- 
1.9.1
