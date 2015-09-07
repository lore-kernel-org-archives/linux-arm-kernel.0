From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon,  7 Sep 2015 17:47:58 +0200
Subject: [PATCH] ARM: at91/dt: add pullup on mmc2 data signals
Message-ID: <1441640878-3575-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMC data lines may be left floating if nothing is currently driving the
data lines, which is the case when mmc is in idle state, thus consuming
a useless extra amount of power. Add pullup on mmc2 data signals in the
same way it was previously done for mmc0 and mmc1.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 arch/arm/boot/dts/sama5d3_mci2.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3_mci2.dtsi b/arch/arm/boot/dts/sama5d3_mci2.dtsi
index 026b252..e21099a 100644
--- a/arch/arm/boot/dts/sama5d3_mci2.dtsi
+++ b/arch/arm/boot/dts/sama5d3_mci2.dtsi
@@ -24,9 +24,9 @@
 					};
 					pinctrl_mmc2_dat1_3: mmc2_dat1_3 {
 						atmel,pins =
-							<AT91_PIOC 12 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PC12 periph A MCI2_DA1 with pullup, conflicts with TIOA1 */
-							 AT91_PIOC 13 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PC13 periph A MCI2_DA2 with pullup, conflicts with TIOB1 */
-							 AT91_PIOC 14 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PC14 periph A MCI2_DA3 with pullup, conflicts with TCLK1 */
+							<AT91_PIOC 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PC12 periph A MCI2_DA1 with pullup, conflicts with TIOA1 */
+							 AT91_PIOC 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PC13 periph A MCI2_DA2 with pullup, conflicts with TIOB1 */
+							 AT91_PIOC 14 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PC14 periph A MCI2_DA3 with pullup, conflicts with TCLK1 */
 					};
 				};
 			};
-- 
2.5.1
