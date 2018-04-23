From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Apr 2018 16:50:30 -0300
Subject: [PATCH 2/5] ARM: dts: imx6dl-aristainetos2_4: Remove
 #address/#size-cells from display0
In-Reply-To: <1524513033-21136-1-git-send-email-festevam@gmail.com>
References: <1524513033-21136-1-git-send-email-festevam@gmail.com>
Message-ID: <1524513033-21136-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unnecessary #address-cells/#size-cells to fix the following
DTC warning:

arch/arm/boot/dts/imx6dl-aristainetos2_4.dtb: Warning (avoid_unnecessary_addr_size): /soc/aips-bus at 2000000/spba-bus at 2000000/ecspi at 2008000/display at 0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
index 7128c76..29940ba 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
@@ -78,8 +78,6 @@
 
 &ecspi1 {
 	lcd_panel: display at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "lg,lg4573";
 		spi-max-frequency = <10000000>;
 		reg = <0>;
-- 
2.7.4
