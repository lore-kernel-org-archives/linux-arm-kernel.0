From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 08 Jul 2017 20:16:34 +0100
Subject: [PATCH 2/6] arm64: dts: marvell: cp110: add GPIO interrupts
In-Reply-To: <20170708191317.GM4902@n2100.armlinux.org.uk>
References: <20170708191317.GM4902@n2100.armlinux.org.uk>
Message-ID: <E1dTvDW-0007Eh-LA@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the GPIO interrupts for the CP110.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 11 ++++++++++-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 68fb35f0386a..a2bfc3b0bef8 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -131,8 +131,12 @@
 					gpio-controller;
 					#gpio-cells = <2>;
 					gpio-ranges = <&cpm_pinctrl 0 0 32>;
+					interrupt-controller;
+					interrupts = <ICU_GRP_NSR 86 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 85 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 84 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 83 IRQ_TYPE_LEVEL_HIGH>;
 					status = "disabled";
-
 				};
 
 				cpm_gpio2: gpio at 140 {
@@ -142,6 +146,11 @@
 					gpio-controller;
 					#gpio-cells = <2>;
 					gpio-ranges = <&cpm_pinctrl 0 32 31>;
+					interrupt-controller;
+					interrupts = <ICU_GRP_NSR 82 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 81 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 80 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 79 IRQ_TYPE_LEVEL_HIGH>;
 					status = "disabled";
 				};
 			};
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index d054684b79bc..036edf86b0f2 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -138,8 +138,12 @@
 					gpio-controller;
 					#gpio-cells = <2>;
 					gpio-ranges = <&cps_pinctrl 0 0 32>;
+					interrupt-controller;
+					interrupts = <ICU_GRP_NSR 86 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 85 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 84 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 83 IRQ_TYPE_LEVEL_HIGH>;
 					status = "disabled";
-
 				};
 
 				cps_gpio2: gpio at 140 {
@@ -149,6 +153,11 @@
 					gpio-controller;
 					#gpio-cells = <2>;
 					gpio-ranges = <&cps_pinctrl 0 32 31>;
+					interrupt-controller;
+					interrupts = <ICU_GRP_NSR 82 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 81 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 80 IRQ_TYPE_LEVEL_HIGH>,
+						     <ICU_GRP_NSR 79 IRQ_TYPE_LEVEL_HIGH>;
 					status = "disabled";
 				};
 
-- 
2.7.4
