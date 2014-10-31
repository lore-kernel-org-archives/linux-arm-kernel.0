From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 21:45:33 +0100
Subject: [PATCH 4/6] ARM: nomadik: set up MCDATDIR2
In-Reply-To: <1414788335-28334-1-git-send-email-linus.walleij@linaro.org>
References: <1414788335-28334-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1414788335-28334-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extra data line for high-speed MMC transfers was unrouted,
set it up properly in the dtsi file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 49b17c7dfb1b..c638c1ce2fc4 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -117,7 +117,7 @@
 			mmcsd_default_mux: mmcsd_mux {
 				mmcsd_default_mux {
 					ste,function = "mmcsd";
-					ste,pins = "mmcsd_a_1";
+					ste,pins = "mmcsd_a_1", "mmcsd_b_1";
 				};
 			};
 			mmcsd_default_mode: mmcsd_default {
@@ -127,9 +127,9 @@
 					ste,output = <0>;
 				};
 				mmcsd_default_cfg2 {
-					/* MCCMDDIR, MCDAT0DIR, MCDAT31DIR */
+					/* MCCMDDIR, MCDAT0DIR, MCDAT31DIR, MCDATDIR2 */
 					ste,pins = "GPIO10_C11", "GPIO15_A12",
-					"GPIO16_C13";
+					"GPIO16_C13", "GPIO23_D15";
 					ste,output = <1>;
 				};
 				mmcsd_default_cfg3 {
-- 
1.9.3
