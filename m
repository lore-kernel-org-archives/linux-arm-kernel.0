From: acourbot@nvidia.com (Alexandre Courbot)
Date: Tue, 15 Mar 2016 11:58:44 +0900
Subject: [PATCH v2 5/5] arm64: tegra210: Add IOMMU node to GM20B
In-Reply-To: <1458010724-10945-1-git-send-email-acourbot@nvidia.com>
References: <1458010724-10945-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1458010724-10945-6-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nouveau can take advantage of this declaration to remove the need for
contiguous memory.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 04898cb25f0c..478543f74863 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -314,6 +314,9 @@
 		clock-names = "gpu", "pwr", "ref";
 		resets = <&tegra_car 184>;
 		reset-names = "gpu";
+
+		iommus = <&mc TEGRA_SWGROUP_GPU>;
+
 		status = "disabled";
 	};
 
-- 
2.7.2
