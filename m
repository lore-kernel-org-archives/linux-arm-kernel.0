From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon, 11 Mar 2013 15:12:40 +0100
Subject: [PATCH 2/2] arm: at91: dt: at91sam9x5: complete NAND pinctrl
In-Reply-To: <1363011160-11297-1-git-send-email-richard.genoud@gmail.com>
References: <1363011160-11297-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1363011160-11297-2-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was only chip enable and readdy/busy pins for the nand controller.
This add the rest of the pins.
pinctrl_nand_16bits contains the specific muxes for 16 bits NANDs.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
based on 3.9-rc2

 arch/arm/boot/dts/at91sam9x5.dtsi |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 9b5d048..a98c0d5 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -238,8 +238,32 @@
 				nand {
 					pinctrl_nand: nand-0 {
 						atmel,pins =
-							<3 4 0x0 0x1	/* PD4 gpio Chip Enable pin pull_up */
-							 3 5 0x0 0x1>;	/* PD5 gpio RDY/BUSY pin pull_up */
+							<3 0 0x1 0x0	/* PD0 periph A Read Enable */
+							 3 1 0x1 0x0	/* PD1 periph A Write Enable */
+							 3 2 0x1 0x0	/* PD2 periph A Address Latch Enable */
+							 3 3 0x1 0x0	/* PD3 periph A Command Latch Enable */
+							 3 4 0x0 0x1	/* PD4 gpio Chip Enable pin pull_up */
+							 3 5 0x0 0x1	/* PD5 gpio RDY/BUSY pin pull_up */
+							 3 6 0x1 0x0	/* PD6 periph A Data bit 0 */
+							 3 7 0x1 0x0	/* PD7 periph A Data bit 1 */
+							 3 8 0x1 0x0	/* PD8 periph A Data bit 2 */
+							 3 9 0x1 0x0	/* PD9 periph A Data bit 3 */
+							 3 10 0x1 0x0	/* PD10 periph A Data bit 4 */
+							 3 11 0x1 0x0	/* PD11 periph A Data bit 5 */
+							 3 12 0x1 0x0	/* PD12 periph A Data bit 6 */
+							 3 13 0x1 0x0>;	/* PD13 periph A Data bit 7 */
+					};
+
+					pinctrl_nand_16bits: nand_16bits-0 {
+						atmel,pins =
+							<3 14 0x1 0x0	/* PD14 periph A Data bit 8 */
+							 3 15 0x1 0x0	/* PD15 periph A Data bit 9 */
+							 3 16 0x1 0x0	/* PD16 periph A Data bit 10 */
+							 3 17 0x1 0x0	/* PD17 periph A Data bit 11 */
+							 3 18 0x1 0x0	/* PD18 periph A Data bit 12 */
+							 3 19 0x1 0x0	/* PD19 periph A Data bit 13 */
+							 3 20 0x1 0x0	/* PD20 periph A Data bit 14 */
+							 3 21 0x1 0x0>;	/* PD21 periph A Data bit 15 */
 					};
 				};
 
-- 
1.7.2.5
