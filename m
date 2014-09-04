From: dgreid@chromium.org (Dylan Reid)
Date: Thu,  4 Sep 2014 15:20:34 -0700
Subject: [PATCH v3 1/2] ARM: tegra: Move pwm and dpaux labels to tegra124.dtsi
Message-ID: <1409869235-8121-1-git-send-email-dgreid@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These labels will be used by other boards in addition to Venice2, move
them to tegra124.dtsi so they are defined in a common place.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
This patch first appeared in v3 of this series.
---
 arch/arm/boot/dts/tegra124-venice2.dts | 4 ++--
 arch/arm/boot/dts/tegra124.dtsi        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index dcbe585..a076a2c 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -36,7 +36,7 @@
 			nvidia,panel = <&panel>;
 		};
 
-		dpaux: dpaux at 0,545c0000 {
+		dpaux at 0,545c0000 {
 			vdd-supply = <&vdd_3v3_panel>;
 			status = "okay";
 		};
@@ -587,7 +587,7 @@
 		status = "okay";
 	};
 
-	pwm: pwm at 0,7000a000 {
+	pwm at 0,7000a000 {
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index a6e4814..0ba3a0b 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -78,7 +78,7 @@
 			status = "disabled";
 		};
 
-		dpaux at 0,545c0000 {
+		dpaux: dpaux at 0,545c0000 {
 			compatible = "nvidia,tegra124-dpaux";
 			reg = <0x0 0x545c0000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
@@ -272,7 +272,7 @@
 		status = "disabled";
 	};
 
-	pwm at 0,7000a000 {
+	pwm: pwm at 0,7000a000 {
 		compatible = "nvidia,tegra124-pwm", "nvidia,tegra20-pwm";
 		reg = <0x0 0x7000a000 0x0 0x100>;
 		#pwm-cells = <2>;
-- 
2.1.0.rc2.206.gedb03e5
