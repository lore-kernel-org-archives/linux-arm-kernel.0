From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 7 Nov 2012 09:26:37 +0800
Subject: [PATCH] ARM: tegra: enable data prefetch on L2
Message-ID: <1352251597-2936-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the data prefetch on L2. The bit28 in aux ctrl register.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index c25746e..c3dee56 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -124,7 +124,7 @@ static void __init tegra_init_cache(void)
 
 	cache_type = readl(p + L2X0_CACHE_TYPE);
 	aux_ctrl = (cache_type & 0x700) << (17-8);
-	aux_ctrl |= 0x6C000001;
+	aux_ctrl |= 0x7C000001;
 
 	ret = l2x0_of_init(aux_ctrl, 0x8200c3fe);
 	if (!ret)
-- 
1.7.0.4
