From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 24 Sep 2015 17:26:48 +0300
Subject: [PATCH 07/17] ARM: dts: am4372: add reset data
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Message-ID: <1443104818-993-8-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset data for pruss, gfx, wkup-m3 and system reset.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0447c04a..fcc8d31 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -116,12 +116,15 @@
 				reg-names = "umem", "dmem";
 				ti,hwmods = "wkup_m3";
 				ti,pm-firmware = "am335x-pm-firmware.elf";
+				reset-names = "wkup_m3";
+				resets = <&prcm 0x2000 0x10 3 0x14 5>;
 			};
 
 			prcm: prcm at 1f0000 {
 				compatible = "ti,am4-prcm";
 				reg = <0x1f0000 0x11000>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				#reset-cells = <5>;
 
 				prcm_clocks: clocks {
 					#address-cells = <1>;
@@ -130,6 +133,12 @@
 
 				prcm_clockdomains: clockdomains {
 				};
+
+				system_reset: system_reset {
+					compatible = "ti,system-reset";
+					reset-names = "system";
+					reset-cells = <&prcm 0x4000 0 0 4 0>;
+				};
 			};
 
 			scm: scm at 210000 {
@@ -1053,6 +1062,21 @@
 			ti,hwmods = "vpfe1";
 			status = "disabled";
 		};
+
+		gfx: gfx at 56000000 {
+			compatible = "ti,am4376-sgx530", "img,sgx530";
+			ti,hwmods = "gfx";
+			status = "disabled";
+			reset-names = "gfx";
+			resets = <&prcm 0x400 0x10 0 0x14 0>;
+		};
+
+		pruss: pruss at 54400000 {
+			compatible = "ti,am4372-pruss";
+			ti,hwmods = "pruss";
+			reset-names = "pruss";
+			resets = <&prcm 0x800 0x10 1 0x14 0>;
+		};
 	};
 };
 
-- 
1.7.9.5
