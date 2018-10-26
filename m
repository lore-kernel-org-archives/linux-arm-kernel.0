From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Fri, 26 Oct 2018 16:19:51 +0000
Subject: [PATCH 2/2] ARM: dts: at91: sama5d2_xplained: Add proper regulator
 states for suspend-to-mem
In-Reply-To: <1540570753-16370-1-git-send-email-claudiu.beznea@microchip.com>
References: <1540570753-16370-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1540570753-16370-3-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

When entering suspend-to-mem, all PMIC outputs are disabled except
VDDIODDR which is put in power saving mode, and whose voltage is
increased (probably to counter the poor accuracy of power saving mode).

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[claudiu.beznea at microchip.com: use regulator-changeable-in-suspend,
 regulator-suspend-max-microvolt, regulator-suspend-max-microvolt]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index fcc85d70f36e..0137d7432834 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -182,6 +182,15 @@
 							regulator-min-microvolt = <1350000>;
 							regulator-max-microvolt = <1350000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-on-in-suspend;
+								regulator-suspend-min-microvolt=<1400000>;
+								regulator-suspend-max-microvolt=<1400000>;
+								regulator-changeable-in-suspend;
+								/* Power saving mode. */
+								regulator-mode=<0>;
+							};
 						};
 
 						vdd_1v2_reg: REG_DCDC2 {
@@ -189,6 +198,10 @@
 							regulator-min-microvolt = <1100000>;
 							regulator-max-microvolt = <1300000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_3v3_reg: REG_DCDC3 {
@@ -196,6 +209,10 @@
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_fuse_reg: REG_LDO1 {
@@ -203,6 +220,10 @@
 							regulator-min-microvolt = <2500000>;
 							regulator-max-microvolt = <2500000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_3v3_lp_reg: REG_LDO2 {
@@ -210,6 +231,10 @@
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_led_reg: REG_LDO3 {
@@ -217,6 +242,10 @@
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_sdhc_1v8_reg: REG_LDO4 {
@@ -224,6 +253,10 @@
 							regulator-min-microvolt = <1800000>;
 							regulator-max-microvolt = <1800000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 					};
 
-- 
2.7.4
