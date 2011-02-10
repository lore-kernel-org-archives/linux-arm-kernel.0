From: ccross@android.com (Colin Cross)
Date: Wed,  9 Feb 2011 22:43:24 -0800
Subject: [PATCH v4 15/15] ARM: tegra: Use writel_relaxed in tegra_init_cache
In-Reply-To: <1297320204-31882-1-git-send-email-ccross@android.com>
References: <1297320204-31882-1-git-send-email-ccross@android.com>
Message-ID: <1297320204-31882-16-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 84a7197..34559d1 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -63,8 +63,8 @@ void __init tegra_init_cache(void)
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
