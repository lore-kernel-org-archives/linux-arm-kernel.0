From: jagarwal@nvidia.com (Jay Agarwal)
Date: Wed, 5 Jun 2013 00:27:32 +0530
Subject: [PATCH V3 4/4] ARM: tegra: pcie: Enable PCIe controller on Cardhu
In-Reply-To: <1370372252-4332-1-git-send-email-jagarwal@nvidia.com>
References: <1370372252-4332-1-git-send-email-jagarwal@nvidia.com>
Message-ID: <1370372252-4332-4-git-send-email-jagarwal@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Enable PCIe controller on Cardhu
- Only port 2 is connected on this board
- Add regulators required for Tegra30

Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
---
Patch is based on remotes/gitorious_thierryreding_linux/tegra/next and should be applied on top of this.

Changes in V3:
- Added num-lanes property for cardhu as per review comments

 arch/arm/boot/dts/tegra30-cardhu.dtsi |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 8ad4841..b6270e3 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -27,6 +27,24 @@
 	model = "NVIDIA Tegra30 Cardhu evaluation board";
 	compatible = "nvidia,cardhu", "nvidia,tegra30";
 
+	pcie-controller {
+		status = "okay";
+		pex-clk-supply = <&pex_hvdd_3v3_reg>;
+		vdd-supply = <&ldo1_reg>;
+		avdd-supply = <&ldo2_reg>;
+
+		pci at 1,0 {
+			nvidia,num-lanes = <4>;
+		};
+		pci at 2,0 {
+			nvidia,num-lanes = <1>;
+		};
+		pci at 3,0 {
+			status = "okay";
+			nvidia,num-lanes = <1>;
+		};
+	};
+
 	host1x {
 		dc at 54200000 {
 			rgb {
-- 
1.7.0.4
