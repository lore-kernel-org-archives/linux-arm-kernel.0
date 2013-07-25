From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Jul 2013 10:53:26 -0700
Subject: [PATCH v5 12/16] ARM: tegra: Enable PCIe controller on Beaver
In-Reply-To: <1374774810-18459-1-git-send-email-thierry.reding@gmail.com>
References: <1374774810-18459-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1374774810-18459-13-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIe lane 0 is connected to an onboard Gigabit Ethernet (RTL8168evl) and
lane 4 is routed to the board's miniPCIe slot.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 87c5f7b..4d9fa31 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -10,6 +10,27 @@
 		reg = <0x80000000 0x7ff00000>;
 	};
 
+	pcie-controller {
+		status = "okay";
+		pex-clk-supply = <&sys_3v3_pexs_reg>;
+		vdd-supply = <&ldo1_reg>;
+		avdd-supply = <&ldo2_reg>;
+
+		pci at 1,0 {
+			status = "okay";
+			nvidia,num-lanes = <4>;
+		};
+
+		pci at 2,0 {
+			status = "okay";
+			nvidia,num-lanes = <1>;
+		};
+
+		pci at 3,0 {
+			nvidia,num-lanes = <1>;
+		};
+	};
+
 	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
-- 
1.8.1.5
