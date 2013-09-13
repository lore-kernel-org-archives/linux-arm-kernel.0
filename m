From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Sep 2013 12:25:10 -0600
Subject: [PATCH 6/7] ARM: tegra: remove tegra_chip_uid()
In-Reply-To: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
References: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1379096711-26875-7-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This function is no longer used. It's also only accurate for Tegra20.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
NOTE: Depends on "crypto: tegra: use kernel entropy instead of ad-hoc",
which is in the crypto tree; not sure for which release...
---
 arch/arm/mach-tegra/fuse.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index e035cd2..64652b3 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -155,13 +155,3 @@ void tegra_init_fuse(void)
 		tegra_sku_id, tegra_cpu_process_id,
 		tegra_core_process_id);
 }
-
-unsigned long long tegra_chip_uid(void)
-{
-	unsigned long long lo, hi;
-
-	lo = tegra_fuse_readl(FUSE_UID_LOW);
-	hi = tegra_fuse_readl(FUSE_UID_HIGH);
-	return (hi << 32ull) | lo;
-}
-EXPORT_SYMBOL(tegra_chip_uid);
-- 
1.8.1.5
