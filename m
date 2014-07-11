From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Fri, 11 Jul 2014 17:18:31 +0300
Subject: [PATCH 6/8] ARM: tegra: Add EMC to Tegra124 device tree
In-Reply-To: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1405088313-20048-7-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a node for the EMC memory controller. It is always enabled,
but only provides read-only functionality without board-specific
timing tables.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 7cc535b..78d629a6 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -136,6 +136,12 @@
 		#reset-cells = <1>;
 	};
 
+	emc at 0,7001b000 {
+		compatible = "nvidia,tegra124-emc";
+		reg = <0x0 0x7001b000 0x0 0x1000>,
+		      <0x0 0x70019000 0x0 0x1000>;
+	};
+
 	gpio: gpio at 0,6000d000 {
 		compatible = "nvidia,tegra124-gpio", "nvidia,tegra30-gpio";
 		reg = <0x0 0x6000d000 0x0 0x1000>;
-- 
1.8.1.5
