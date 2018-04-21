From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 21 Apr 2018 20:30:31 +0200
Subject: [PATCH] ARM: dts: exynos: Fix invalid node referenced by i2c20 alias
Message-ID: <20180421183031.21195-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After moving all nodes under "soc" node in commit 5d99cc59a3c6 ("ARM:
dts: exynos: Move Exynos5250 and Exynos5420 nodes under soc"), the i2c20
alias stopped point to proper node:

    arch/arm/boot/dts/exynos5420-peach-pit.dtb: Warning (alias_paths):
        /aliases:i2c20: aliases property is not a valid node (/spi at 12d40000/cros-ec at 0/i2c-tunnel)
    arch/arm/boot/dts/exynos5800-peach-pi.dtb: Warning (alias_paths):
        /aliases:i2c20: aliases property is not a valid node (/spi at 12d40000/cros-ec at 0/i2c-tunnel)

Fixes: 5d99cc59a3c6 ("ARM: dts: exynos: Move Exynos5250 and Exynos5420 nodes under soc")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 4 ++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 244f0091c21f..57c2332bf282 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -29,7 +29,7 @@
 
 	aliases {
 		/* Assign 20 so we don't get confused w/ builtin ones */
-		i2c20 = "/spi at 12d40000/cros-ec at 0/i2c-tunnel";
+		i2c20 = &i2c_tunnel;
 	};
 
 	backlight: backlight {
@@ -970,7 +970,7 @@
 			samsung,spi-feedback-delay = <1>;
 		};
 
-		i2c-tunnel {
+		i2c_tunnel: i2c-tunnel {
 			compatible = "google,cros-ec-i2c-tunnel";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 2f8df9244f72..d80ab9085da1 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -27,7 +27,7 @@
 
 	aliases {
 		/* Assign 20 so we don't get confused w/ builtin ones */
-		i2c20 = "/spi at 12d40000/cros-ec at 0/i2c-tunnel";
+		i2c20 = &i2c_tunnel;
 	};
 
 	backlight: backlight {
@@ -939,7 +939,7 @@
 			samsung,spi-feedback-delay = <1>;
 		};
 
-		i2c-tunnel {
+		i2c_tunnel: i2c-tunnel {
 			compatible = "google,cros-ec-i2c-tunnel";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.14.1
