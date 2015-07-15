From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 19:59:52 +0100
Subject: [PATCH 6/7] ARM: dt: dove: add GPU power domain description
In-Reply-To: <20150715185859.GC7557@n2100.arm.linux.org.uk>
References: <20150715185859.GC7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFRuK-0003mR-2O@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the description of the GPU power domain to the PMU DT entry.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/dove.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 6e7edc5a2a0d..7f86236b2438 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -402,6 +402,13 @@
 						marvell,pmu_iso_mask = <0x00000001>;
 						resets = <&pmu 16>;
 					};
+
+					gpu_domain: gpu-domain {
+						#power-domain-cells = <0>;
+						marvell,pmu_pwr_mask = <0x00000004>;
+						marvell,pmu_iso_mask = <0x00000002>;
+						resets = <&pmu 18>;
+					};
 				};
 
 				thermal: thermal-diode at 001c {
-- 
2.1.0
