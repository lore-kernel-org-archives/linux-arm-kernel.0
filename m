From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 13 Oct 2014 12:33:51 +0200
Subject: [PATCH 09/12] ARM: tegra: Add memory controller support for Tegra124
In-Reply-To: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1413196434-5292-9-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add the memory controller and wire up the interrupt that is used to
report errors. Provide a reference to the memory controller clock and
mark the device as being an IOMMU by adding an #iommu-cells property.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 478c555ebd96..afe9c6a34709 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -551,6 +551,17 @@
 		reset-names = "fuse";
 	};
 
+	mc: memory-controller at 0,70019000 {
+		compatible = "nvidia,tegra124-mc";
+		reg = <0x0 0x70019000 0x0 0x1000>;
+		clocks = <&tegra_car TEGRA124_CLK_MC>;
+		clock-names = "mc";
+
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+
+		#iommu-cells = <1>;
+	};
+
 	sata at 0,70020000 {
 		compatible = "nvidia,tegra124-ahci";
 
-- 
2.1.2
