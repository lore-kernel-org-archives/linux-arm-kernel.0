From: stefan@agner.ch (Stefan Agner)
Date: Sun, 17 Dec 2017 21:37:18 +0100
Subject: [PATCH v2 4/9] ARM: dts: imx7-colibri: use NAND_CE1 as GPIO
In-Reply-To: <20171217203723.15896-1-stefan@agner.ch>
References: <20171217203723.15896-1-stefan@agner.ch>
Message-ID: <20171217203723.15896-4-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Colibri iMX7 SKUs use either single-die NAND or eMMC, hence
NAND_CE1 is not used on the module and can be used as a GPIO by
carrier boards.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index e4e32aa786f4..f61041af026a 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -329,6 +329,7 @@
 			MX7D_PAD_EPDC_SDCE2__GPIO2_IO22		0x14 /* SODIMM 127 */
 			MX7D_PAD_UART3_RTS_B__GPIO4_IO6		0x14 /* SODIMM 131 */
 			MX7D_PAD_EPDC_GDRL__GPIO2_IO26		0x14 /* SODIMM 133 */
+			MX7D_PAD_SAI1_RX_DATA__GPIO6_IO12	0x14 /* SODIMM 169 */
 			MX7D_PAD_SAI1_RX_BCLK__GPIO6_IO17	0x14 /* SODIMM 24 */
 			MX7D_PAD_SD2_DATA2__GPIO5_IO16		0x14 /* SODIMM 100 */
 			MX7D_PAD_SD2_DATA3__GPIO5_IO17		0x14 /* SODIMM 102 */
@@ -439,7 +440,6 @@
 			MX7D_PAD_SD3_CLK__NAND_CLE		0x71
 			MX7D_PAD_SD3_CMD__NAND_ALE		0x71
 			MX7D_PAD_SAI1_TX_BCLK__NAND_CE0_B	0x71
-			MX7D_PAD_SAI1_RX_DATA__NAND_CE1_B	0x71
 			MX7D_PAD_SAI1_TX_DATA__NAND_READY_B	0x74
 			MX7D_PAD_SD3_STROBE__NAND_RE_B		0x71
 			MX7D_PAD_SD3_RESET_B__NAND_WE_B		0x71
-- 
2.15.1
