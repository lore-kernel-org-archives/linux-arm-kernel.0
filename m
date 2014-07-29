From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 29 Jul 2014 18:28:59 +0200
Subject: [RFC 5/5] ARM: dts: Improve Peach Pit and Pi power scheme model
In-Reply-To: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1406651339-28901-6-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DeviceTree files for the Peach Pit and Pi machines have
a simplistic model of the connections between the different
regulators since not all the tps65090 regulators get their
input supply voltage from the VDC. DCDC1-3, LD0-1 and fet7
parent supply is indded VDC but the fet1-6 get their input
supply from the DCDC1 and DCDC2 output voltage rails.

This information has to be present in the DTS since fets
are switches that don't provide an output voltage so when
this is needed, the parent input supply voltage is queried.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 12 ++++++------
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 7656a42..acc2936 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -367,12 +367,12 @@
 				vsys2-supply = <&vbat>;
 				vsys3-supply = <&vbat>;
 				infet1-supply = <&vbat>;
-				infet2-supply = <&vbat>;
-				infet3-supply = <&vbat>;
-				infet4-supply = <&vbat>;
-				infet5-supply = <&vbat>;
-				infet6-supply = <&vbat>;
-				infet7-supply = <&vbat>;
+				infet2-supply = <&tps65090_dcdc1>;
+				infet3-supply = <&tps65090_dcdc2>;
+				infet4-supply = <&tps65090_dcdc2>;
+				infet5-supply = <&tps65090_dcdc2>;
+				infet6-supply = <&tps65090_dcdc2>;
+				infet7-supply = <&tps65090_dcdc1>;
 				vsys-l1-supply = <&vbat>;
 				vsys-l2-supply = <&vbat>;
 
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 5f3e54f..6b83b98 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -365,12 +365,12 @@
 				vsys2-supply = <&vbat>;
 				vsys3-supply = <&vbat>;
 				infet1-supply = <&vbat>;
-				infet2-supply = <&vbat>;
-				infet3-supply = <&vbat>;
-				infet4-supply = <&vbat>;
-				infet5-supply = <&vbat>;
-				infet6-supply = <&vbat>;
-				infet7-supply = <&vbat>;
+				infet2-supply = <&tps65090_dcdc1>;
+				infet3-supply = <&tps65090_dcdc2>;
+				infet4-supply = <&tps65090_dcdc2>;
+				infet5-supply = <&tps65090_dcdc2>;
+				infet6-supply = <&tps65090_dcdc2>;
+				infet7-supply = <&tps65090_dcdc1>;
 				vsys-l1-supply = <&vbat>;
 				vsys-l2-supply = <&vbat>;
 
-- 
2.0.0.rc2
