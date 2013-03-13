From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 14 Mar 2013 01:19:53 +0530
Subject: [PATCH V3 4/5] ARM: tegra: add KBC nodes to Tegra114 DT
In-Reply-To: <1363204194-19487-1-git-send-email-ldewangan@nvidia.com>
References: <1363204194-19487-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1363204194-19487-5-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA's Tegra114 SoCs have the matrix keyboard controller which
supports 11x8 type of matrix. The number of rows and columns
are configurable.

Add DT entry for KBC controller with compatibility as "nvidia,tegra114-kbc".

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- Add compatible for kbc as nvidia,tegra114-kbc and nvidia,tegra20-kbc.

Changes from V2:
- Rebase to for-3.10/dt of Stephen's Tegra tree.
- Remove compatibilty of prev hardware as it has 11x8 matrix,

 arch/arm/boot/dts/tegra114.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 5a41d04..d2bbfaf 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -218,6 +218,14 @@
 		interrupts = <0 2 0x04>;
 	};
 
+	kbc {
+		compatible = "nvidia,tegra114-kbc";
+		reg = <0x7000e200 0x100>;
+		interrupts = <0 85 0x04>;
+		clocks = <&tegra_car 36>;
+		status = "disabled";
+	};
+
 	pmc {
 		compatible = "nvidia,tegra114-pmc", "nvidia,tegra30-pmc";
 		reg = <0x7000e400 0x400>;
-- 
1.7.1.1
