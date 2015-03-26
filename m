From: stefan@agner.ch (Stefan Agner)
Date: Thu, 26 Mar 2015 08:24:05 +0100
Subject: [PATCH] ARM: dts: vf610: fix missing irqs
Message-ID: <1427354645-16629-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While adding the MSCM interrupt router, all interrupts have been moved
to vfxxx.dtsi again. However, some properties got lost. Readd the
missing interrupt properties.

Offending commit:
97e6466ab9 ("ARM: dts: vf610: add Miscellaneous System Control Module (MSCM)"
---
 arch/arm/boot/dts/vfxxx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 899645d..f9bef55 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -377,6 +377,7 @@
 			src: src at 4006e000 {
 				compatible = "fsl,vf610-src", "syscon";
 				reg = <0x4006e000 0x1000>;
+				interrupts = <96 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			gpc: gpc at 4006c000 {
@@ -419,6 +420,7 @@
 				snvsrtc: snvs-rtc-lp at 34 {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
 					reg = <0x34 0x58>;
+					interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks VF610_CLK_SNVS>;
 					clock-names = "snvs-rtc";
 				};
-- 
2.3.3
