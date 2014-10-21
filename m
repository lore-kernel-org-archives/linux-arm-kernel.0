From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Oct 2014 16:45:39 +0200
Subject: [PATCH v2 07/12] ARM: tegra: Add EMC to Tegra124 device tree
In-Reply-To: <1413902788-7727-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1413902788-7727-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1413902788-7727-8-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikko Perttunen <mperttunen@nvidia.com>

This adds a node for the EMC memory controller. It is always enabled, but only
provides read-only functionality without board-specific timing tables.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 0ee30f6..97c9f8b 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -567,6 +567,13 @@
 		#iommu-cells = <1>;
 	};
 
+	emc at 0,7001b000 {
+		compatible = "nvidia,tegra124-emc";
+		reg = <0x0 0x7001b000 0x0 0x1000>;
+
+		nvidia,memory-controller = <&mc>;
+	};
+
 	sata at 0,70020000 {
 		compatible = "nvidia,tegra124-ahci";
 
-- 
1.9.3
