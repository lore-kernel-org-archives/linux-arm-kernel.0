From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 23 Feb 2017 18:30:50 +0100
Subject: [PATCH 08/11] arm64: tegra: Enable current monitors on P3310
In-Reply-To: <20170223173053.19701-1-thierry.reding@gmail.com>
References: <20170223173053.19701-1-thierry.reding@gmail.com>
Message-ID: <20170223173053.19701-8-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The P3310 processor module contains two current monitors that can be
used to determine the current flow across various parts of the board
design.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index b18e166527d8..a1cb6b35314e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -56,6 +56,16 @@
 
 	i2c at 3160000 {
 		status = "okay";
+
+		power-monitor at 40 {
+			compatible = "ti,ina3221";
+			reg = <0x40>;
+		};
+
+		power-monitor at 41 {
+			compatible = "ti,ina3221";
+			reg = <0x41>;
+		};
 	};
 
 	i2c at 3180000 {
-- 
2.11.1
