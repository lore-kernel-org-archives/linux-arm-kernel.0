From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 18 Feb 2014 23:03:31 +0100
Subject: [PATCH] ARM: tegra: Add head numbers to display controllers
Message-ID: <1392761011-21701-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The number of the head specifies the index of the display controller
unit and is required to properly configure outputs so that they receive
video data from the correct source.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Hi Olof, Kevin,

Stephen requested that I send this patch your way so that it can be
applied for 3.14. They aren't strictly necessary because there's a
fallback if they are missing but if they aren't present, the driver
will output undesirable error messages.

Thanks,
Thierry

 arch/arm/boot/dts/tegra114.dtsi | 4 ++++
 arch/arm/boot/dts/tegra20.dtsi  | 4 ++++
 arch/arm/boot/dts/tegra30.dtsi  | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 389e987ec281..44ec401ec366 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -57,6 +57,8 @@
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
 
+			nvidia,head = <0>;
+
 			rgb {
 				status = "disabled";
 			};
@@ -72,6 +74,8 @@
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
 
+			nvidia,head = <1>;
+
 			rgb {
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 480ecda3416b..48d2a7f4d0c0 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -94,6 +94,8 @@
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
 
+			nvidia,head = <0>;
+
 			rgb {
 				status = "disabled";
 			};
@@ -109,6 +111,8 @@
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
 
+			nvidia,head = <1>;
+
 			rgb {
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 18d52a7704cc..7f995739c1a7 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -170,6 +170,8 @@
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
 
+			nvidia,head = <0>;
+
 			rgb {
 				status = "disabled";
 			};
@@ -185,6 +187,8 @@
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
 
+			nvidia,head = <1>;
+
 			rgb {
 				status = "disabled";
 			};
-- 
1.8.4.2
