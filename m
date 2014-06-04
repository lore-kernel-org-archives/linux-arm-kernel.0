From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 4 Jun 2014 14:32:32 +0300
Subject: [PATCH 2/9] ARM: tegra: Add SATA controller to Tegra124 device tree
In-Reply-To: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1401881559-18469-3-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the integrated AHCI-compliant Serial ATA controller present
in Tegra124 systems-on-chip to the Tegra124 device tree.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Cc: devicetree at vger.kernel.org
---
 arch/arm/boot/dts/tegra124.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 90f11ea..e647f30 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -787,6 +787,30 @@
 		status = "disabled";
 	};
 
+	sata at 0,70020000 {
+		compatible = "nvidia,tegra124-ahci";
+
+		reg = <0x0 0x70027000 0x0 0x2000>, /* AHCI */
+			<0x0 0x70020000 0x0 0x7000>; /* SATA */
+
+		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&tegra_car TEGRA124_CLK_SATA>,
+			<&tegra_car TEGRA124_CLK_SATA_OOB>,
+			<&tegra_car TEGRA124_CLK_CML1>,
+			<&tegra_car TEGRA124_CLK_PLL_E>;
+
+		resets = <&tegra_car 124>,
+			<&tegra_car 123>,
+			<&tegra_car 129>;
+		reset-names = "sata", "sata-oob", "sata-cold";
+
+		phys = <&padctl TEGRA_XUSB_PADCTL_SATA>;
+		phy-names = "sata-phy";
+
+		status = "disabled";
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.1.5
