From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Thu,  4 Sep 2014 16:02:52 +0300
Subject: [PATCH 1/2] ARM: dts: cm-t54: fix serial console power supply.
In-Reply-To: <1409835773-22782-1-git-send-email-lifshitz@compulab.co.il>
References: <1409835773-22782-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1409835773-22782-2-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LDO8 regulator is used for act led and serial cosole power supply.

Its DT status is declared as "disabled", however the serial console was
functional until Commit 318dbb02b ("regulator: palmas: Fix SMPS
enable/disable/is_enabled") wich properly turns off LDO8 on boot.

Fix serial cosole power supply (and act led) on boot by turning LDO8 on.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap5-cm-t54.dts |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index b8698ca..429471a 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -353,13 +353,12 @@
 				};
 
 				ldo8_reg: ldo8 {
-					/* VDD_3v0: Does not go anywhere */
+					/* VDD_3V_GP: act led/serial console */
 					regulator-name = "ldo8";
 					regulator-min-microvolt = <3000000>;
 					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
 					regulator-boot-on;
-					/* Unused */
-					status = "disabled";
 				};
 
 				ldo9_reg: ldo9 {
-- 
1.7.5.4
