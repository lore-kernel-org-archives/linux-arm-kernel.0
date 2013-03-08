From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 8 Mar 2013 19:23:01 +0530
Subject: [PATCH 4/5] ARM: DT: tegra114: add KBC controller DT entry
In-Reply-To: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
References: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1362750782-15174-5-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA's Tegra114 SoCs have the matrix keyboard controller which
supports 11x8 type of matrix. The number of rows and columns
are configurable.

Add DT entry for KBC controller.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 686e33f..18fbd49 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -248,6 +248,14 @@
 		clocks = <&tegra_car 4>;
 	};
 
+	kbc {
+		compatible = "nvidia,tegra20-kbc";
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
