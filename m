From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Fri, 24 Oct 2014 17:39:22 +0300
Subject: [PATCH v5 15/16] ARM: tegra: Add CPU regulator to the Jetson TK1
 device tree
In-Reply-To: <1414161563-16812-1-git-send-email-mikko.perttunen@kapsi.fi>
References: <1414161563-16812-1-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <1414161563-16812-16-git-send-email-mikko.perttunen@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify the CPU voltage regulator for the cpufreq driver.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
---
v5:
- Duplicate the cpus/cpu at 0 structure here instead of referring to a named
  'cpu0' node. This fits in better with the style used by Tegra device trees.

 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 116b6a0..0902860 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1773,6 +1773,12 @@
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
2.1.0
