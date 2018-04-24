From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Apr 2018 17:27:24 -0300
Subject: [PATCH] arm64: dts: ls208xa-rdb: Pass unit name to SPI flash node
Message-ID: <1524601644-23607-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass unit name to SPI flash node to match its 'reg' value and
also avoid the following DTC warnings:

arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: Warning (unit_address_vs_reg): /soc/dspi at 2100000/n25q512a: node has a reg or ranges property, but no unit name
arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dtb: Warning (unit_address_vs_reg): /soc/dspi at 2100000/n25q512a: node has a reg or ranges property, but no unit name

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
index 5498c70..061647b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
@@ -134,7 +134,7 @@
 
 &dspi {
 	status = "okay";
-	dflash0: n25q512a {
+	dflash0: n25q512a at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p80";
-- 
2.7.4
