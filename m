From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Dec 2013 16:59:30 +0100
Subject: [PATCH 06/10] ARM: tegra: Add Tegra114 gr2d support
In-Reply-To: <1387468774-14216-1-git-send-email-treding@nvidia.com>
References: <1387468774-14216-1-git-send-email-treding@nvidia.com>
Message-ID: <1387468774-14216-7-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device tree for the gr2d hardware found on Tegra114 SoCs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- add resets and reset-names properties

Changes in v2:
- mark as backwards-compatible with Tegra20

 arch/arm/boot/dts/tegra114.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 28d2eea46b52..3dd7b50d8f93 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -30,6 +30,15 @@
 
 		ranges = <0x54000000 0x54000000 0x01000000>;
 
+		gr2d at 54140000 {
+			compatible = "nvidia,tegra114-gr2d", "nvidia,tegra20-gr2d";
+			reg = <0x54140000 0x00040000>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA114_CLK_GR2D>;
+			resets = <&tegra_car 21>;
+			reset-names = "2d";
+		};
+
 		dc at 54200000 {
 			compatible = "nvidia,tegra114-dc", "nvidia,tegra20-dc";
 			reg = <0x54200000 0x00040000>;
-- 
1.8.4.2
