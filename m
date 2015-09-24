From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 24 Sep 2015 17:26:49 +0300
Subject: [PATCH 08/17] ARM: dts: am33xx: add reset data
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Message-ID: <1443104818-993-9-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset data for pruss, gfx, wkup-m3, and system reset.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index d23e252..3974c3b 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -110,11 +110,14 @@
 				reg-names = "umem", "dmem";
 				ti,hwmods = "wkup_m3";
 				ti,pm-firmware = "am335x-pm-firmware.elf";
+				reset-names = "wkup_m3";
+				resets = <&prcm 0xd00 0 3 0xc 5>;
 			};
 
 			prcm: prcm at 200000 {
 				compatible = "ti,am3-prcm";
 				reg = <0x200000 0x4000>;
+				#reset-cells = <5>;
 
 				prcm_clocks: clocks {
 					#address-cells = <1>;
@@ -123,6 +126,12 @@
 
 				prcm_clockdomains: clockdomains {
 				};
+
+				system_reset: system_reset {
+					compatible = "ti,system-reset";
+					reset-names = "system";
+					resets = <&prcm 0xf00 0 0 8 1>;
+				};
 			};
 
 			scm: scm at 210000 {
@@ -879,6 +888,21 @@
 			reg = <0x48310000 0x2000>;
 			interrupts = <111>;
 		};
+
+		pruss: pruss at 4a300000 {
+			compatible = "ti,am3352-pruss";
+			ti,hwmods = "pruss";
+			reset-names = "pruss";
+			resets = <&prcm 0xc00 0 1 0 1>;
+		};
+
+		gfx: gfx at 56000000 {
+			compatible = "ti,am3352-sgx530", "img,sgx530";
+			ti,hwmods = "gfx";
+			status = "disabled";
+			reset-names = "gfx";
+			resets = <&prcm 0x1100 0x4 0 0x14 0>;
+		};
 	};
 };
 
-- 
1.7.9.5
