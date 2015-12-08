From: carlo@caione.org (Carlo Caione)
Date: Tue,  8 Dec 2015 14:24:48 +0100
Subject: [PATCH] ARM: DTS: Amlogic: Add TWD support to Meson8b
Message-ID: <1449581088-23491-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add support for the ARM TWD Timer and Watchdog to the Amlogic Meson8b
device tree.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index ee352bf..4860854 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -51,6 +51,18 @@
 / {
 	interrupt-parent = <&gic>;
 
+	timer at c4300600 {
+		compatible = "arm,cortex-a5-twd-timer";
+		reg = <0xc4300600 0x20>;
+		interrupts = <1 13 0xf08>;
+	};
+
+	watchdog at c4300620 {
+		compatible = "arm,cortex-a5-twd-wdt";
+		reg = <0xc4300620 0x20>;
+		interrupts = <1 14 0xf08>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.9.1
