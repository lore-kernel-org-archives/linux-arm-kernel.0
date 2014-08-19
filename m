From: tuomas.tynkkynen@iki.fi (Tuomas Tynkkynen)
Date: Tue, 19 Aug 2014 06:33:25 +0300
Subject: [PATCH v3 15/15] ARM: tegra: Add CPU regulator to the Jetson TK1
 device tree
In-Reply-To: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>
References: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>
Message-ID: <1408419205-10048-16-git-send-email-tuomas.tynkkynen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

Add the CPU voltage regulator for the cpufreq driver.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
v3: New patch
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 0c30450..4be7c82 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1858,3 +1858,7 @@
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
+
+&cpu0 {
+	vdd-cpu-supply = <&vdd_cpu>;
+};
-- 
1.8.1.5
