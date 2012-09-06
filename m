From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 06 Sep 2012 14:53:01 +0530
Subject: [PATCH 2/2] ARM: dts: exynos4: allow i2c0 bus to be configured using
 pinctrl interface
In-Reply-To: <1346923381-14144-1-git-send-email-thomas.abraham@linaro.org>
References: <1346923381-14144-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1346923381-14144-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a default pin state for i2c0 controller which the pinctrl interface can
use to setup the i2c0 bus.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4210-smdkv310.dts |    2 --
 arch/arm/boot/dts/exynos4210.dtsi         |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 1beccc8..ea76542 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -126,8 +126,6 @@
 		#size-cells = <0>;
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <20000>;
-		gpios = <&gpd1 0 2 3 0>,
-			<&gpd1 1 2 3 0>;
 
 		eeprom at 50 {
 			compatible = "samsung,24ad0xd1";
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index a4bd0c9..e08387f 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -157,6 +157,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13860000 0x100>;
 		interrupts = <0 58 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c0_bus>;
 	};
 
 	i2c at 13870000 {
-- 
1.6.6.rc2
