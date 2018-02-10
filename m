From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Sat, 10 Feb 2018 02:38:01 +0100
Subject: [PATCH 1/6] arm: tegra: apalis-tk1: set critical trips
In-Reply-To: <20180210013806.28496-1-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com>
Message-ID: <20180210013806.28496-2-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Set "critical" trip temperatures for cpu, gpu, mem and pllx
thermal zones. These trips can trigger shut down or reset.

Similar to commit 40823f8e267f ("arm: tegra: set critical
trips for Tegra124").

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis.dtsi | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 7aef8928e115..be45b6753916 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -2041,53 +2041,32 @@
 	thermal-zones {
 		cpu {
 			trips {
-				trip at 0 {
+				cpu-shutdown-trip {
 					temperature = <101000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				/*
-				 * There are currently no cooling maps because
-				 * there are no cooling devices
-				 */
-			};
 		};
 
 		mem {
 			trips {
-				trip at 0 {
+				mem-shutdown-trip {
 					temperature = <101000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				/*
-				 * There are currently no cooling maps because
-				 * there are no cooling devices
-				 */
-			};
 		};
 
 		gpu {
 			trips {
-				trip at 0 {
+				gpu-shutdown-trip {
 					temperature = <101000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				/*
-				 * There are currently no cooling maps because
-				 * there are no cooling devices
-				 */
-			};
 		};
 	};
 };
-- 
2.14.3
