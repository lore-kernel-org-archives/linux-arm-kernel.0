From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 24 Sep 2015 17:26:47 +0300
Subject: [PATCH 06/17] ARM: dts: dra7: add reset data
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Message-ID: <1443104818-993-7-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy over the reset data from kernel to DT. Currently, only system reset
has been defined, but rest can be added later once needed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5d65db9..e299b07 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -199,6 +199,7 @@
 				compatible = "ti,dra7-prm";
 				reg = <0x6000 0x3000>;
 				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				#reset-cells = <5>;
 
 				prm_clocks: clocks {
 					#address-cells = <1>;
@@ -207,6 +208,12 @@
 
 				prm_clockdomains: clockdomains {
 				};
+
+				system_reset: system_reset {
+					compatible = "ti,system-reset";
+					reset-names = "system";
+					resets = <&prm 0x1d00 0 0 4 0>;
+				};
 			};
 		};
 
-- 
1.7.9.5
