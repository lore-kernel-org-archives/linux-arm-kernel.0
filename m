From: jagarwal@nvidia.com (Jay Agarwal)
Date: Wed, 8 May 2013 16:27:40 +0530
Subject: [PATCH 4/4] ARM: tegra: pcie: Enable PCIe controller on Cardhu
In-Reply-To: <1368010660-31465-1-git-send-email-jagarwal@nvidia.com>
References: <1368010660-31465-1-git-send-email-jagarwal@nvidia.com>
Message-ID: <1368010660-31465-4-git-send-email-jagarwal@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Enable PCIe controller on Cardhu
- Only port 2 is connected on this board
- Add regulators required for Tegra30
- Patch is based on remotes/gitorious_thierryreding_linux/tegra/next
- and should be applied on top of this.

Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
---
 arch/arm/boot/dts/tegra30-cardhu.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index d2fdf95..8f8e07b 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -27,6 +27,17 @@
 	model = "NVIDIA Tegra30 Cardhu evaluation board";
 	compatible = "nvidia,cardhu", "nvidia,tegra30";
 
+	pcie-controller {
+		status = "okay";
+		pex-clk-supply = <&pex_hvdd_3v3_reg>;
+		vdd-supply = <&ldo1_reg>;
+		avdd-supply = <&ldo2_reg>;
+
+		pci at 3,0 {
+			status = "okay";
+		};
+	};
+
 	host1x {
 		dc at 54200000 {
 			rgb {
-- 
1.7.0.4
