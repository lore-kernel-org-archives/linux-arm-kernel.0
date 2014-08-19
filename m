From: tuomas.tynkkynen@iki.fi (Tuomas Tynkkynen)
Date: Tue, 19 Aug 2014 06:33:20 +0300
Subject: [PATCH v3 10/15] ARM: tegra: Enable the DFLL on the Jetson TK1
In-Reply-To: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>
References: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>
Message-ID: <1408419205-10048-11-git-send-email-tuomas.tynkkynen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

Add the board-specific properties of the DFLL for the Jetson TK1 board.
On this board, the DFLL will take control of the sd0 regulator on the
on-board AS3722 PMIC.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 624b0fb..0c30450 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1453,7 +1453,7 @@
 				vin-ldo9-10-supply = <&vdd_5v0_sys>;
 				vin-ldo11-supply = <&vdd_3v3_run>;
 
-				sd0 {
+				vdd_cpu: sd0 {
 					regulator-name = "+VDD_CPU_AP";
 					regulator-min-microvolt = <700000>;
 					regulator-max-microvolt = <1400000>;
@@ -1662,6 +1662,12 @@
 		non-removable;
 	};
 
+	dfll at 0,70110000 {
+		status = "okay";
+		vdd-cpu-supply = <&vdd_cpu>;
+		nvidia,i2c-fs-rate = <400000>;
+	};
+
 	ahub at 0,70300000 {
 		i2s at 0,70301100 {
 			status = "okay";
-- 
1.8.1.5
