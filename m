From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 12 Mar 2015 18:31:21 +0000
Subject: [PATCH 6/9] ARM: dt: dove: add Dove PMU DT entry to dove.dtsi
In-Reply-To: <20150312183020.GU8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Message-ID: <E1YW7tB-0003mM-1L@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PMU description to the Dove DT file.  The PMU provides multiple
features, including an interrupt, reset, power and isolation controller.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/dove.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index a5441d5482a6..43d4ebf414be 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -380,6 +380,15 @@
 				status = "disabled";
 			};
 
+			pmu: power-management at d0000 {
+				compatible = "marvell,dove-pmu";
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
