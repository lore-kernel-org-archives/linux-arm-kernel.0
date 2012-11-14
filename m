From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 14 Nov 2012 16:27:23 +0200
Subject: [PATCH] ARM: tegra: Implement 6395/1 for Tegra
Message-ID: <1352903243-5389-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements ARM linux patch 6395/1 for Tegra. See commit
1a8e41cd672f894bbd74874eac601e6cedf838fb for details.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index e635abb..0816562 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -125,7 +125,7 @@ static void __init tegra_init_cache(void)
 
 	cache_type = readl(p + L2X0_CACHE_TYPE);
 	aux_ctrl = (cache_type & 0x700) << (17-8);
-	aux_ctrl |= 0x7C000001;
+	aux_ctrl |= 0x7C400001;
 
 	ret = l2x0_of_init(aux_ctrl, 0x8200c3fe);
 	if (!ret)
-- 
1.7.7.rc0.72.g4b5ea.dirty
