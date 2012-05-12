From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 May 2012 18:12:49 -0600
Subject: [PATCH] ARM: dt: tegra cardhu: fix typo in SDHCI node name
Message-ID: <1336781569-27422-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Cardhu's eMMC controller is on sdhci at 78000600, not sdhci at 78000400.
Fix the typo. This roughly doubles the IO performance, since the
support-8bit property actually takes effect.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-cardhu.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
index facb950..f23da40 100644
--- a/arch/arm/boot/dts/tegra-cardhu.dts
+++ b/arch/arm/boot/dts/tegra-cardhu.dts
@@ -139,7 +139,7 @@
 		status = "disable";
 	};
 
-	sdhci at 78000400 {
+	sdhci at 78000600 {
 		support-8bit;
 	};
 
-- 
1.7.0.4
