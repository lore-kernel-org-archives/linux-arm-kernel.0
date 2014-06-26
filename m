From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 26 Jun 2014 22:49:45 +0200
Subject: [RFC 05/10] ARM: tegra: Add memory controller on Tegra124
In-Reply-To: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1403815790-8548-6-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add the memory controller and wire up the interrupt that is used to
report errors. Also add an #iommu-cells property to make the device
as an IOMMU.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 0bf050696186..efa0f0c519be 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -560,6 +560,15 @@
 		reset-names = "fuse";
 	};
 
+	mc: memory-controller at 0,70019000 {
+		compatible = "nvidia,tegra124-mc";
+		reg = <0x0 0x70019000 0x0 0x1000>;
+
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+
+		#iommu-cells = <1>;
+	};
+
 	hda at 0,70030000 {
 		compatible = "nvidia,tegra124-hda", "nvidia,tegra30-hda";
 		reg = <0x0 0x70030000 0x0 0x10000>;
-- 
2.0.0
