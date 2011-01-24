From: ccross@android.com (Colin Cross)
Date: Sun, 23 Jan 2011 18:01:29 -0800
Subject: [PATCH v2 24/28] ARM: tegra: Use writel_relaxed in tegra_init_cache
In-Reply-To: <1295834493-5019-1-git-send-email-ccross@android.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
Message-ID: <1295834493-5019-25-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 1b32495..dc41669 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -68,8 +68,8 @@ void tegra_init_cache(void)
 #ifdef CONFIG_CACHE_L2X0
 	void __iomem *p = IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x3000;
 
-	writel(0x331, p + L2X0_TAG_LATENCY_CTRL);
-	writel(0x441, p + L2X0_DATA_LATENCY_CTRL);
+	writel_relaxed(0x331, p + L2X0_TAG_LATENCY_CTRL);
+	writel_relaxed(0x441, p + L2X0_DATA_LATENCY_CTRL);
 
 	l2x0_init(p, 0x6C080001, 0x8200c3fe);
 #endif
-- 
1.7.3.1
