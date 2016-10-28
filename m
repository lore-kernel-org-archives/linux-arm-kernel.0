From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 28 Oct 2016 21:37:00 +0900
Subject: [PATCH v2 6/8] ARM: dts: am335x: Add the charger interrupt
In-Reply-To: <20161028123702.21849-1-woogyom.kim@gmail.com>
References: <20161028123702.21849-1-woogyom.kim@gmail.com>
Message-ID: <20161028123702.21849-7-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the charger driver gets corresponding IRQ number by using
platform_get_irq_byname() helper.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 25303d9..cec9d91 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <dt-bindings/mfd/tps65217.h>
+
 / {
 	cpus {
 		cpu at 0 {
@@ -316,6 +318,12 @@
 
 	ti,pmic-shutdown-controller;
 
+	charger {
+		interrupts = <TPS65217_IRQ_AC>, <TPS65217_IRQ_USB>;
+		interrupts-names = "AC", "USB";
+		status = "okay";
+	};
+
 	regulators {
 		dcdc1_reg: regulator at 0 {
 			regulator-name = "vdds_dpr";
-- 
2.9.3
