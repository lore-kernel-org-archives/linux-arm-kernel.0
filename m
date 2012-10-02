From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  2 Oct 2012 13:10:47 -0600
Subject: [PATCH 1/2] ARM: tegra: fix invalid unit-address in tegra*.dtsi
Message-ID: <1349205048-22228-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Unit addresses, whilst written in hex, don't contain a 0x prefix.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
A couple of small cleanups/tweaks for 3.7 if possible.

 arch/arm/boot/dts/tegra20-seaboard.dts |    2 +-
 arch/arm/boot/dts/tegra20.dtsi         |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index e60dc71..f0ba901 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -539,7 +539,7 @@
 		nvidia,invert-interrupt;
 	};
 
-	memory-controller at 0x7000f400 {
+	memory-controller at 7000f400 {
 		emc-table at 190000 {
 			reg = <190000>;
 			compatible = "nvidia,tegra20-emc-table";
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 67a6cd9..f3a09d0 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -170,7 +170,7 @@
 		reg = <0x7000e400 0x400>;
 	};
 
-	memory-controller at 0x7000f000 {
+	memory-controller at 7000f000 {
 		compatible = "nvidia,tegra20-mc";
 		reg = <0x7000f000 0x024
 		       0x7000f03c 0x3c4>;
@@ -183,7 +183,7 @@
 		       0x58000000 0x02000000>;	/* GART aperture */
 	};
 
-	memory-controller at 0x7000f400 {
+	memory-controller at 7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
 		#address-cells = <1>;
-- 
1.7.0.4
