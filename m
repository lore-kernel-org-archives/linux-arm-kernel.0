From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 19:59:46 +0100
Subject: [PATCH 5/7] ARM: dt: dove: add video decoder power domain description
In-Reply-To: <20150715185859.GC7557@n2100.arm.linux.org.uk>
References: <20150715185859.GC7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFRuE-0003mL-V2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the description of the video decoder power domain to the PMU DT
entry.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/dove.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index d4d33266c65c..6e7edc5a2a0d 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -396,6 +396,12 @@
 				#reset-cells = <1>;
 
 				domains {
+					vpu_domain: vpu-domain {
+						#power-domain-cells = <0>;
+						marvell,pmu_pwr_mask = <0x00000008>;
+						marvell,pmu_iso_mask = <0x00000001>;
+						resets = <&pmu 16>;
+					};
 				};
 
 				thermal: thermal-diode at 001c {
-- 
2.1.0
