From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  4 Dec 2017 10:20:14 -0200
Subject: [PATCH v2 10/12] ARM: dts: imx6q-h100: Remove unneeded unit address
In-Reply-To: <1512390016-703-1-git-send-email-festevam@gmail.com>
References: <1512390016-703-1-git-send-email-festevam@gmail.com>
Message-ID: <1512390016-703-10-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove the unneeded unit address for the port nodes in order to fix
the following build warnings with W=1:

arch/arm/boot/dts/imx6q-h100.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/i2c at 21a0000/tc358743 at f/port at 0 has a unit name, but no reg property
arch/arm/boot/dts/imx6q-h100.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 0 has a unit name, but no reg property

Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/imx6q-h100.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-h100.dts b/arch/arm/boot/dts/imx6q-h100.dts
index 743c11f..cc1ce46 100644
--- a/arch/arm/boot/dts/imx6q-h100.dts
+++ b/arch/arm/boot/dts/imx6q-h100.dts
@@ -205,7 +205,7 @@
 		reset-gpios = <&gpio6 15 GPIO_ACTIVE_LOW>;
 		/* IRQ has a wrong pull resistor which renders it useless  */
 
-		port at 0 {
+		port {
 			tc358743_out: endpoint {
 				remote-endpoint = <&mipi_csi2_in>;
 				data-lanes = <1 2 3 4>;
@@ -348,7 +348,7 @@
 &mipi_csi {
 	status = "okay";
 
-	port at 0 {
+	port {
 		mipi_csi2_in: endpoint {
 			remote-endpoint = <&tc358743_out>;
 			data-lanes = <1 2 3 4>;
-- 
2.7.4
