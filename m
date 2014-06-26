From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 26 Jun 2014 22:49:47 +0200
Subject: [RFC 07/10] ARM: tegra: tegra124: Enable IOMMU for SDMMC controllers
In-Reply-To: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1403815790-8548-8-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The SDMMC controllers can use the IOMMU to avoid the need for bounce
buffers.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 82751d2878c4..bfffb4c102fb 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -607,6 +607,7 @@
 		resets = <&tegra_car 14>;
 		reset-names = "sdhci";
 		status = "disabled";
+		iommus = <&mc TEGRA_SWGROUP_SDMMC1A>;
 	};
 
 	sdhci at 0,700b0200 {
@@ -618,6 +619,7 @@
 		resets = <&tegra_car 9>;
 		reset-names = "sdhci";
 		status = "disabled";
+		iommus = <&mc TEGRA_SWGROUP_SDMMC2A>;
 	};
 
 	sdhci at 0,700b0400 {
@@ -629,6 +631,7 @@
 		resets = <&tegra_car 69>;
 		reset-names = "sdhci";
 		status = "disabled";
+		iommus = <&mc TEGRA_SWGROUP_SDMMC3A>;
 	};
 
 	sdhci at 0,700b0600 {
@@ -640,6 +643,7 @@
 		resets = <&tegra_car 15>;
 		reset-names = "sdhci";
 		status = "disabled";
+		iommus = <&mc TEGRA_SWGROUP_SDMMC4A>;
 	};
 
 	ahub at 0,70300000 {
-- 
2.0.0
