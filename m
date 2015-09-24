From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 24 Sep 2015 17:26:46 +0300
Subject: [PATCH 05/17] ARM: dts: omap5: add reset data
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Message-ID: <1443104818-993-6-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy over the reset data from hwmod database to DT. After this is taken
into use, the data in hwmod database can be removed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 4205a8a..631a8ae 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -242,6 +242,7 @@
 				compatible = "ti,omap5-prm";
 				reg = <0x6000 0x3000>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				#reset-cells = <5>;
 
 				prm_clocks: clocks {
 					#address-cells = <1>;
@@ -250,6 +251,12 @@
 
 				prm_clockdomains: clockdomains {
 				};
+
+				system_reset: system_reset {
+					compatible = "ti,system-reset";
+					reset-names = "system";
+					resets = <&prm 0x1c00 0 0 4 0>;
+				};
 			};
 
 			scrm: scrm at a000 {
@@ -614,6 +621,8 @@
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmu_dsp";
 			#iommu-cells = <0>;
+			reset-names = "mmu_cache";
+			resets = <&prm 0x400 0x10 1 0x14 1>;
 		};
 
 		mmu_ipu: mmu at 55082000 {
@@ -623,6 +632,8 @@
 			ti,hwmods = "mmu_ipu";
 			#iommu-cells = <0>;
 			ti,iommu-bus-err-back;
+			reset-names = "mmu_cache";
+			resets = <&prm 0x700 0x210 2 0x214 2>;
 		};
 
 		keypad: keypad at 4ae1c000 {
-- 
1.7.9.5
