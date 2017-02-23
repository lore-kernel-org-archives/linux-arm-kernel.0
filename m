From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 23 Feb 2017 18:30:47 +0100
Subject: [PATCH 05/11] arm64: tegra: Enable ethernet on P3310
In-Reply-To: <20170223173053.19701-1-thierry.reding@gmail.com>
References: <20170223173053.19701-1-thierry.reding@gmail.com>
Message-ID: <20170223173053.19701-5-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The P3310 processor module provides networking via the ethernet
controller found on NVIDIA Tegra186 SoCs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index 762f4756346c..ffbb4be5122e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -26,6 +26,26 @@
 		reg = <0x0 0x80000000 0x2 0x00000000>;
 	};
 
+	ethernet at 2490000 {
+		status = "okay";
+
+		phy-reset-gpios = <&gpio TEGRA_MAIN_GPIO(M, 4) GPIO_ACTIVE_LOW>;
+		phy-handle = <&phy>;
+		phy-mode = "rgmii";
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			phy: phy at 0 {
+				compatible = "ethernet-phy-ieee802.3-c22";
+				reg = <0x0>;
+				interrupt-parent = <&gpio>;
+				interrupts = <TEGRA_MAIN_GPIO(M, 5) IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+	};
+
 	serial at 3100000 {
 		status = "okay";
 	};
-- 
2.11.1
