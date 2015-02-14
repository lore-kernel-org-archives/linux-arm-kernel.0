From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 14 Feb 2015 15:27:51 +0000
Subject: [PATCH 5/8] ARM: dt: dove: add Dove PMU DT entry to dove.dtsi
In-Reply-To: <20150214152659.GI8656@n2100.arm.linux.org.uk>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
Message-ID: <E1YMedL-00054h-4W@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PMU description to the Dove DT file.  The PMU provides multiple
features, including an interrupt, reset, power and isolation controller.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/dove.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index a5441d5482a6..1e664eb8bdcb 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -380,6 +380,15 @@
 				status = "disabled";
 			};
 
+			pmu: power-management at d0000 {
+				compatible = "marvell,pmu";
+				reg = <0xd0000 0x8000>, <0xd8000 0x8000>;
+				interrupts = <33>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				#reset-cells = <1>;
+			};
+
 			thermal: thermal-diode at d001c {
 				compatible = "marvell,dove-thermal";
 				reg = <0xd001c 0x0c>, <0xd005c 0x08>;
-- 
1.8.3.1
