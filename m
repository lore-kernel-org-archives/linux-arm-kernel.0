From: yungching0725@gmail.com (Ken Lin)
Date: Sat,  4 Mar 2017 05:20:32 +0800
Subject: [PATCH] ARM: dts: imx6q-bx50v3/imx6q-b450v3/imx6q-b650v3: fix at25
 spi-clk frequency issue
Message-ID: <20170303212032.31725-1-yungching0725@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the maxium spi clock frequency from 20MHz to 10MHz to meet the operation voltage range requirement recommended in AT25 datasheet

Signed-off-by: Ken Lin <yungching0725@gmail.com>
---
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index f99e6efda3e2..614c40e5f772 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -103,7 +103,7 @@
 
 	m25_eeprom: m25p80 at 0 {
 		compatible = "atmel,at25";
-		spi-max-frequency = <20000000>;
+		spi-max-frequency = <10000000>;
 		size = <0x8000>;
 		pagesize = <64>;
 		reg = <0>;
-- 
2.11.0
