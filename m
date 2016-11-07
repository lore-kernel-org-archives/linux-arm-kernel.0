From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 07 Nov 2016 15:39:34 +0530
Subject: [PATCH 4/6] ARM: dts: Add clock provider specific properties to
 max8997 node
In-Reply-To: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
References: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1478513376-14307-5-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a label and #clock-cells property to device node of
max8997 PMIC to allow using it as a clock provider.

CC: Rob Herring <robh+dt@kernel.org>
CC: devicetree at vger.kernel.org
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 3 ++-
 arch/arm/boot/dts/exynos4210-trats.dts  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index cb3a255..6c7ef4e 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -147,11 +147,12 @@
 	pinctrl-0 = <&i2c0_bus>;
 	pinctrl-names = "default";
 
-	max8997_pmic at 66 {
+	max8997: max8997_pmic at 66 {
 		compatible = "maxim,max8997-pmic";
 		reg = <0x66>;
 		interrupt-parent = <&gpx0>;
 		interrupts = <4 0>, <3 0>;
+		#clock-cells = <1>;
 
 		max8997,pmic-buck1-dvs-voltage = <1350000>;
 		max8997,pmic-buck2-dvs-voltage = <1100000>;
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 0ca1b4d..74a9d39 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -295,12 +295,13 @@
 	pinctrl-names = "default";
 	status = "okay";
 
-	max8997_pmic at 66 {
+	max8997: max8997_pmic at 66 {
 		compatible = "maxim,max8997-pmic";
 
 		reg = <0x66>;
 		interrupt-parent = <&gpx0>;
 		interrupts = <7 0>;
+		#clock-cells = <1>;
 
 		max8997,pmic-buck1-uses-gpio-dvs;
 		max8997,pmic-buck2-uses-gpio-dvs;
-- 
2.7.4
