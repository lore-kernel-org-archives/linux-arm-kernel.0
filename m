From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 12 Mar 2015 15:48:00 +0100
Subject: [PATCH v8 08/18] ARM: tegra: Add EMC to Tegra124 device tree
In-Reply-To: <1426171746-26864-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1426171746-26864-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1426171746-26864-9-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikko Perttunen <mperttunen@nvidia.com>

This adds a node for the EMC memory controller. It is always enabled, but only
provides read-only functionality without board-specific timing tables.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

---

v5: Add a phandle to the CAR node that points to the EMC node
---
 arch/arm/boot/dts/tegra124.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 4be06c6..0fff4fb 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -207,6 +207,7 @@
 		reg = <0x0 0x60006000 0x0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		nvidia,external-memory-controller = <&emc>;
 	};
 
 	flow-controller at 0,60007000 {
@@ -569,6 +570,13 @@
 		#iommu-cells = <1>;
 	};
 
+	emc: emc at 0,7001b000 {
+		compatible = "nvidia,tegra124-emc";
+		reg = <0x0 0x7001b000 0x0 0x1000>;
+
+		nvidia,memory-controller = <&mc>;
+	};
+
 	sata at 0,70020000 {
 		compatible = "nvidia,tegra124-ahci";
 
-- 
2.1.0
