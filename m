From: jagarwal@nvidia.com (Jay Agarwal)
Date: Mon, 8 Apr 2013 21:11:28 +0530
Subject: [PATCH 3/3] ARM: dts: tegra: Add PCIe entry for cardhu
In-Reply-To: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
References: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
Message-ID: <1365435688-4179-3-git-send-email-jagarwal@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>

- Add PCIe node entry for cardhu
- Enable only root port 2
- Initialize regulators required for tegra30
- Based on git://gitorious.org/thierryreding/linux.git

 arch/arm/boot/dts/tegra30-cardhu.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index d2fdf95..b64113e 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -137,6 +137,17 @@
 		};
 	};
 
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
 	serial at 70006000 {
 		status = "okay";
 	};
-- 
1.7.0.4
