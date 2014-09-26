From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Fri, 26 Sep 2014 12:43:12 +0300
Subject: [PATCH v6 3/4] ARM: tegra: Add thermal trip points for Jetson TK1
In-Reply-To: <1411724593-4037-1-git-send-email-cyndis@kapsi.fi>
References: <1411724593-4037-1-git-send-email-cyndis@kapsi.fi>
Message-ID: <1411724593-4037-4-git-send-email-cyndis@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikko Perttunen <mperttunen@nvidia.com>

This adds critical trip points to the Jetson TK1 device tree.
The device will do a controlled shutdown when either the CPU, GPU
or MEM thermal zone reaches 101 degrees Celsius.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v6: added comments to cooling map nodes

 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 0cdb5cf..66a5eaf 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1876,4 +1876,48 @@
 			 <&tegra_car TEGRA124_CLK_EXTERN1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	thermal-zones {
+		cpu {
+			trips {
+				trip at 0 {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				/* There are currently no cooling maps because there are no cooling devices */
+			};
+		};
+
+		mem {
+			trips {
+				trip at 0 {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				/* There are currently no cooling maps because there are no cooling devices */
+			};
+		};
+
+		gpu {
+			trips {
+				trip at 0 {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				/* There are currently no cooling maps because there are no cooling devices */
+			};
+		};
+	};
 };
-- 
2.1.0
