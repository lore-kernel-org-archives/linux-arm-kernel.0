From: josh.wu@atmel.com (Josh Wu)
Date: Sun, 4 Jan 2015 17:02:28 +0800
Subject: [PATCH v2 3/8] ARM: at91: dts: sama5d3: add missing pins of isi
In-Reply-To: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
References: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1420362153-500-4-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bo Shen <voice.shen@atmel.com>

The ISI has 12 data lines, add the missing two data lines.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 595609f..b3ac156 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -568,6 +568,12 @@
 							 AT91_PIOC 28 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC28 periph C ISI_PD9, conflicts with SPI1_NPCS3, PWMFI0 */
 					};
 
+					pinctrl_isi_data_10_11: isi-0-data-10-11 {
+						atmel,pins =
+							<AT91_PIOC 27 AT91_PERIPH_C AT91_PINCTRL_NONE	/* PC27 periph C ISI_PD10, conflicts with SPI1_NPCS2, TWCK1 */
+							 AT91_PIOC 26 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC26 periph C ISI_PD11, conflicts with SPI1_NPCS1, TWD1 */
+					};
+
 					pinctrl_isi_pck_as_mck: isi_pck_as_mck-0 {
 						atmel,pins =
 							<AT91_PIOD 31 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PD31 periph B ISI_MCK */
-- 
1.9.1
