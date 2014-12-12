From: digetx@gmail.com (Dmitry Osipenko)
Date: Fri, 12 Dec 2014 18:19:19 +0300
Subject: [PATCH] ARM: dts: tegra20: fix GR3D, DSI unit and reg base addresses
Message-ID: <1418397559-19646-1-git-send-email-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 58ecb23f64ee ("ARM: tegra: add missing unit addresses to DT") added
unit address and changed reg base for GR3D and DSI host1x modules, but these
addresses belongs to GR2D and TVO modules respectively. Fix it by changing
modules unit and reg base addresses to proper ones.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Fixes: 58ecb23f64ee (ARM: tegra: add missing unit addresses to DT)
Cc: <stable@vger.kernel.org> # v3.13+
---
 arch/arm/boot/dts/tegra20.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 8acf5d8..f76fe94 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -68,9 +68,9 @@
 			reset-names = "2d";
 		};
 
-		gr3d at 54140000 {
+		gr3d at 54180000 {
 			compatible = "nvidia,tegra20-gr3d";
-			reg = <0x54140000 0x00040000>;
+			reg = <0x54180000 0x00040000>;
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
 			resets = <&tegra_car 24>;
 			reset-names = "3d";
@@ -130,9 +130,9 @@
 			status = "disabled";
 		};
 
-		dsi at 542c0000 {
+		dsi at 54300000 {
 			compatible = "nvidia,tegra20-dsi";
-			reg = <0x542c0000 0x00040000>;
+			reg = <0x54300000 0x00040000>;
 			clocks = <&tegra_car TEGRA20_CLK_DSI>;
 			resets = <&tegra_car 48>;
 			reset-names = "dsi";
-- 
2.2.0
