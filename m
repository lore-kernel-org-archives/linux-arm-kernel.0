From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  4 Sep 2014 22:31:21 -0300
Subject: [PATCH v2 4/6] ARM: dts: imx28-m28cu: Fix display duplicate name
 warning
In-Reply-To: <1409880683-27402-1-git-send-email-festevam@gmail.com>
References: <1409880683-27402-1-git-send-email-festevam@gmail.com>
Message-ID: <1409880683-27402-4-git-send-email-festevam@gmail.com>
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

 arch/arm/boot/dts/imx28-m28cu3.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index 9348ce5..2df63be 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -115,10 +115,10 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a
 					     &lcdif_pins_m28>;
-				display = <&display>;
+				display = <&display0>;
 				status = "okay";
 
-				display: display0 {
+				display0: display0 {
 					bits-per-pixel = <32>;
 					bus-width = <24>;
 
-- 
1.9.1
