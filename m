From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 29 Jan 2013 18:26:23 +0530
Subject: [PATCH 7/7] ARM: DT: tegra114: add KBC controller DT entry
In-Reply-To: <1359464183-6255-1-git-send-email-ldewangan@nvidia.com>
References: <1359464183-6255-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1359464183-6255-8-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA's Tegra114 SoCs have the matrix keyboard controller which
supports 11x8 type of matrix. The number of rows and columns
are configurable.

Add DT entry for KBC controller.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 17fd061..73a49f5 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -199,6 +199,13 @@
 		interrupts = <0 2 0x04>;
 	};
 
+	kbc {
+		compatible = "nvidia,tegra20-kbc";
+		reg = <0x7000e200 0x100>;
+		interrupts = <0 85 0x04>;
+		status = "disabled";
+	};
+
 	pmc {
 		compatible = "nvidia,tegra114-pmc", "nvidia,tegra30-pmc";
 		reg = <0x7000e400 0x400>;
-- 
1.7.1.1
