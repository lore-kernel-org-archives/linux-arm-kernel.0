From: joelagnel@ti.com (Joel A Fernandes)
Date: Tue, 25 Jun 2013 20:24:48 -0500
Subject: [PATCH 3/5] ARM: dts: am33xx: Add interrupts and memory resources for
 MMC
Message-ID: <1372209888-6649-1-git-send-email-joelagnel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joel A Fernandes <agnel.joel@gmail.com>

HWMOD irq entries for MMC were removed. We provide the same from DT for MMC.

This fixes issue where memory resource could not be found during probe.
Also, added the reg-offset property to account for the offset from start.

Signed-off-by: Joel A Fernandes <agnel.joel@gmail.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 119f8a9..e0a5741 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -237,6 +237,10 @@
 			dmas = <&edma 24
 				&edma 25>;
 			dma-names = "tx", "rx";
+			interrupts = <64>;
+			interrupt-parent = <&intc>;
+			reg = <0x48060000 0x1000>;
+			reg-offset = <0x100>;
 			status = "disabled";
 		};
 
@@ -247,6 +251,10 @@
 			dmas = <&edma 2
 				&edma 3>;
 			dma-names = "tx", "rx";
+			interrupts = <24>;
+			interrupt-parent = <&intc>;
+			reg = <0x481d8000 0x1000>;
+			reg-offset = <0x100>;
 			status = "disabled";
 		};
 
@@ -254,6 +262,10 @@
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
+			interrupts = <25>;
+			interrupt-parent = <&intc>;
+			reg = <0x47810000 0x1000>;
+			reg-offset = <0x100>;
 			status = "disabled";
 		};
 
-- 
1.7.9.5
