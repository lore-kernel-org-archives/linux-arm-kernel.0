From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 16 Jan 2017 17:56:53 +0100
Subject: [PATCH] ARM: shmobile: r8a7779: marzen: Fix sata device status
Message-ID: <1484585813-22534-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device nodes representing I/O devices should be marked disabled in the
SoC-specific DTS, and overridden by board-specific DTSes where needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 4 ++++
 arch/arm/boot/dts/r8a7779.dtsi       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 676151b70185d1a5..89c5b24a3d03f049 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -216,6 +216,10 @@
 	};
 };
 
+&sata {
+	status = "okay";
+};
+
 &scif2 {
 	pinctrl-0 = <&scif2_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index f47a0edc26d4879c..ae2d9a9c65af43c0 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -347,6 +347,7 @@
 		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
 		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
+		status = "disabled";
 	};
 
 	sdhi0: sd at ffe4c000 {
-- 
1.9.1
