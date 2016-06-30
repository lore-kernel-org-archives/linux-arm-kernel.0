From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 30 Jun 2016 17:01:19 +0900
Subject: [PATCH] arm64: tegra: Enable all cores on Jetson TX1
Message-ID: <20160630080119.27090-1-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PSCI firmware and all 4 cores of T210 on Jetson TX1.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Not sure why this was not done - in any case this seems to work fine
and performance is obviously improved (especially boot time).

 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index bb319daf6aa5..6e7fe0517e5c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -71,4 +71,27 @@
 			regulator-enable-ramp-delay = <1000>;
 		};
 	};
+
+	cpus {
+		cpu at 0 {
+			enable-method = "psci";
+		};
+
+		cpu at 1 {
+			enable-method = "psci";
+		};
+
+		cpu at 2 {
+			enable-method = "psci";
+		};
+
+		cpu at 3 {
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
 };
-- 
2.9.0
