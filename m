From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Sun,  1 Mar 2015 14:44:40 +0200
Subject: [PATCH v8 17/18] ARM: tegra: Add CPU regulator to the Jetson TK1
 device tree
In-Reply-To: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <1425213881-5262-18-git-send-email-mikko.perttunen@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify the CPU voltage regulator for the cpufreq driver.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index f0888dd..e723759 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1782,6 +1782,12 @@
 		};
 	};
 
+	cpus {
+		cpu at 0 {
+			vdd-cpu-supply = <&vdd_cpu>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
-- 
2.3.0
