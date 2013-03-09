From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Sat, 9 Mar 2013 23:41:17 +0530
Subject: [PATCH V2 4/5] ARM: DT: tegra114: add KBC controller DT entry
In-Reply-To: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
References: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1362852678-13421-5-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA's Tegra114 SoCs have the matrix keyboard controller which
supports 11x8 type of matrix. The number of rows and columns
are configurable.

Add DT entry for KBC controller with compatibility as "nvidia,tegra114-kbc",
"nvidia,tegra20-kbc".

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- Add compatible for kbc as nvidia,tegra114-kbc and nvidia,tegra20-kbc.

 arch/arm/boot/dts/tegra114.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 300082d..21ff340 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -248,6 +248,14 @@
 		clocks = <&tegra_car 4>;
 	};
 
+	kbc {
+		compatible = "nvidia,tegra114-kbc", "nvidia,tegra20-kbc";
+		reg = <0x7000e200 0x100>;
+		interrupts = <0 85 0x04>;
+		clocks = <&tegra_car 36>;
+		status = "disabled";
+	};
+
 	pmc {
 		compatible = "nvidia,tegra114-pmc";
 		reg = <0x7000e400 0x400>;
-- 
1.7.1.1
