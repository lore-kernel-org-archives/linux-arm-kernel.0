From: josh.wu@atmel.com (Josh Wu)
Date: Sun, 4 Jan 2015 17:02:29 +0800
Subject: [PATCH v2 4/8] ARM: at91: dts: sama5d3: move the isi mck pin to mb
In-Reply-To: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
References: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1420362153-500-5-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bo Shen <voice.shen@atmel.com>

The mck is decided by the board design, move it to mb related
dtsi file.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 arch/arm/boot/dts/sama5d3.dtsi    | 5 -----
 arch/arm/boot/dts/sama5d3xmb.dtsi | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index b3ac156..ed734e9 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -573,11 +573,6 @@
 							<AT91_PIOC 27 AT91_PERIPH_C AT91_PINCTRL_NONE	/* PC27 periph C ISI_PD10, conflicts with SPI1_NPCS2, TWCK1 */
 							 AT91_PIOC 26 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC26 periph C ISI_PD11, conflicts with SPI1_NPCS1, TWD1 */
 					};
-
-					pinctrl_isi_pck_as_mck: isi_pck_as_mck-0 {
-						atmel,pins =
-							<AT91_PIOD 31 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PD31 periph B ISI_MCK */
-					};
 				};
 
 				mmc0 {
diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 2530541..6af1cba 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -117,6 +117,11 @@
 							<AT91_PIOD 30 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PD30 periph B */
 					};
 
+					pinctrl_isi_pck_as_mck: isi_pck_as_mck-0 {
+						atmel,pins =
+							<AT91_PIOD 31 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PD31 periph B ISI_MCK */
+					};
+
 					pinctrl_isi_reset: isi_reset-0 {
 						atmel,pins =
 							<AT91_PIOE 24 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;   /* PE24 gpio */
-- 
1.9.1
