From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 15:11:55 -0600
Subject: [PATCH] misc: fuse: fix dummy functions
Message-ID: <1402953115-32489-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Tegra fuse header's dummy functions for the case where Tegra20 is
disabled are inconsistent with the correct prototypes, and have some
syntax errors. Fix these. While at it, fix the indentation level of
the dummy function bodies.

Fixes: 40969e30ad7c ("misc: fuse: Add efuse driver for Tegra")
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I intend to immediately apply this to Tegra's for-3.17/fuse-move branch.
---
 drivers/misc/fuse/tegra/fuse.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/fuse/tegra/fuse.h b/drivers/misc/fuse/tegra/fuse.h
index b3442770df09..3a398bf3572c 100644
--- a/drivers/misc/fuse/tegra/fuse.h
+++ b/drivers/misc/fuse/tegra/fuse.h
@@ -38,14 +38,14 @@ void tegra20_init_fuse_early(void);
 u32 tegra20_fuse_early(const unsigned int offset);
 #else
 static inline void tegra20_init_speedo_data(struct tegra_sku_info *sku_info) {}
-static inline bool tegra20_spare_fuse_early(int spare_bit, void *fuse_base)
+static inline bool tegra20_spare_fuse_early(int spare_bit)
 {
-			return false;
+	return false;
 }
-static inline void tegra20_init_fuse_early(void);
-static inline tegra20_fuse_early(const unsigned int offset);
+static inline void tegra20_init_fuse_early(void) {}
+static inline u32 tegra20_fuse_early(const unsigned int offset)
 {
-			return 0;
+	return 0;
 }
 #endif
 
-- 
1.8.1.5
