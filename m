From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 1 Jul 2015 18:13:45 +0900
Subject: [PATCH 1/4] ARM: tegra: Add IOMMU node to GK20A
In-Reply-To: <1435742028-8237-1-git-send-email-acourbot@nvidia.com>
References: <1435742028-8237-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1435742028-8237-2-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nouveau can make use of the IOMMU to make physical appear linear in the
GPU address space.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 13cc7ca5e031..bffe90236bf8 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -188,6 +188,9 @@
 		clock-names = "gpu", "pwr";
 		resets = <&tegra_car 184>;
 		reset-names = "gpu";
+
+		iommus = <&mc TEGRA_SWGROUP_GPU>;
+
 		status = "disabled";
 	};
 
-- 
2.4.4
