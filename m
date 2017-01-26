From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Jan 2017 11:11:03 +0100
Subject: [PATCH 1/7] ARM: dts: r8a7779, marzen: Fix sata device status
In-Reply-To: <cover.1485425227.git.horms+renesas@verge.net.au>
References: <cover.1485425227.git.horms+renesas@verge.net.au>
Message-ID: <e8aa6811ca9547bc82baa6ed44c38dde01fb0d86.1485425227.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Device nodes representing I/O devices should be marked disabled in the
SoC-specific DTS, and overridden by board-specific DTSes where needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 4 ++++
 arch/arm/boot/dts/r8a7779.dtsi       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 676151b70185..89c5b24a3d03 100644
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
index f47a0edc26d4..ae2d9a9c65af 100644
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
2.7.0.rc3.207.g0ac5344
