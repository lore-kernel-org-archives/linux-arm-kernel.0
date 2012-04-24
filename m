From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Apr 2012 20:35:36 -0300
Subject: [PATCH 1/2] ARM: imx6q-sabrelite.dts: Add SPI NOR support
Message-ID: <1335310537-11219-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx6qsabrelite has a sst25vf016b SPI NOR flash connected to eCSPI1.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 4663a4e..35be687 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -22,6 +22,23 @@
 	};
 
 	soc {
+		aips-bus at 02000000 { /* AIPS1 */
+			spba-bus at 02000000 {
+				ecspi at 02008000 { /* eCSPI1 */
+					fsl,spi-num-chipselects = <1>;
+					cs-gpios = <&gpio3 19 0>;
+					status = "okay";
+
+					flash: m25p80 at 0 {
+						compatible = "sst,sst25vf016b";
+						spi-max-frequency = <20000000>;
+						reg = <0>;
+					};
+				};
+			};
+
+		};
+
 		aips-bus at 02100000 { /* AIPS2 */
 			enet at 02188000 {
 				phy-mode = "rgmii";
-- 
1.7.1
