From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  2 Dec 2016 14:57:16 +0100
Subject: [RFC PATCH 5/5] ARM: at91/dt: sama5d2_xplained: Add proper regulator
 states for suspend-to-mem
In-Reply-To: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1480687036-5037-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When entering suspend-to-mem, all PMIC outputs are disabled except
VDDIODDR which is put in power saving mode, and whose voltage is
increased (probably to counter the poor accuracy of power saving mode).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index da47fa19f474..db1fe0091c2a 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -178,6 +178,14 @@
 							regulator-min-microvolt = <1350000>;
 							regulator-max-microvolt = <1350000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-on-in-suspend;
+								regulator-suspend-microvolt = <1400000>;
+								/* Power saving mode. */
+								regulator-mode = <0>;
+								regulator-allow-changes-at-runtime;
+							};
 						};
 
 						vdd_1v2_reg: REG_DCDC2 {
@@ -185,6 +193,10 @@
 							regulator-min-microvolt = <1100000>;
 							regulator-max-microvolt = <1300000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_3v3_reg: REG_DCDC3 {
@@ -192,6 +204,10 @@
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_fuse_reg: REG_LDO1 {
@@ -199,6 +215,10 @@
 							regulator-min-microvolt = <2500000>;
 							regulator-max-microvolt = <2500000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_3v3_lp_reg: REG_LDO2 {
@@ -206,6 +226,10 @@
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_led_reg: REG_LDO3 {
@@ -213,6 +237,10 @@
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_sdhc_1v8_reg: REG_LDO4 {
@@ -220,6 +248,10 @@
 							regulator-min-microvolt = <1800000>;
 							regulator-max-microvolt = <1800000>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 					};
 				};
-- 
2.7.4
