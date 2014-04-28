From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 12:51:46 -0600
Subject: [PATCH] ARM: tegra: add SD wp-gpios to Dalmore DT
Message-ID: <1398711106-22484-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Dalmore can detect write-protect on the SD card. Add the required
DT entries to allow this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 35a2ee71a970..5c21d216515a 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1106,6 +1106,7 @@
 
 	sdhci at 78000400 {
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 		status = "okay";
 	};
-- 
1.8.1.5
