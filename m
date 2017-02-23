From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 23 Feb 2017 18:30:53 +0100
Subject: [PATCH 11/11] arm64: tegra: Add GPIO expanders on P2771
In-Reply-To: <20170223173053.19701-1-thierry.reding@gmail.com>
References: <20170223173053.19701-1-thierry.reding@gmail.com>
Message-ID: <20170223173053.19701-11-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The P2771 development board expands the number of GPIOs via two I2C
chips.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index 9485841e3351..eac75764bf3c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -18,6 +18,28 @@
 			compatible = "ti,ina3221";
 			reg = <0x43>;
 		};
+
+		exp1: gpio at 74 {
+			compatible = "ti,tca9539";
+			reg = <0x74>;
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_MAIN_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		exp2: gpio at 77 {
+			compatible = "ti,tca9539";
+			reg = <0x77>;
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_MAIN_GPIO(Y, 6) GPIO_ACTIVE_LOW>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
 	};
 
 	gpio-keys {
-- 
2.11.1
