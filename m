From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 13 Jul 2015 13:39:56 +0100
Subject: [PATCH V3 18/19] ARM: tegra: add GPU power supply to Jetson TK1 DT
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1436791197-32358-19-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vince Hsu <vinceh@nvidia.com>

Add power supply information which is board dependent for GK20A.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index ce5961cd0b77..2b355957635c 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1514,7 +1514,7 @@
 					regulator-always-on;
 				};
 
-				sd6 {
+				vdd_gpu: sd6 {
 					regulator-name = "+VDD_GPU_AP";
 					regulator-min-microvolt = <650000>;
 					regulator-max-microvolt = <1200000>;
@@ -1635,6 +1635,10 @@
 		};
 	};
 
+	gpu-power-domain {
+		vdd-supply = <&vdd_gpu>;
+	};
+
 	/* Serial ATA */
 	sata at 0,70020000 {
 		status = "okay";
-- 
2.1.4
