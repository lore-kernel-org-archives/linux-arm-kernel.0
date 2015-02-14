From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 14 Feb 2015 15:28:06 +0000
Subject: [PATCH 8/8] ARM: dt: dove: add GPU power domain description
In-Reply-To: <20150214152659.GI8656@n2100.arm.linux.org.uk>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
Message-ID: <E1YMeda-00054u-GA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the description of the GPU power domain to the PMU DT entry.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/dove.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index a47c7cef380f..081f968c521a 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -394,6 +394,13 @@
 					marvell,pmu_iso_mask = <0x00000001>;
 					resets = <&pmu 16>;
 				};
+
+				gpu_domain: gpu-domain {
+					#power-domain-cells = <0>;
+					marvell,pmu_pwr_mask = <0x00000004>;
+					marvell,pmu_iso_mask = <0x00000002>;
+					resets = <&pmu 18>;
+				};
 			};
 
 			thermal: thermal-diode at d001c {
-- 
1.8.3.1
