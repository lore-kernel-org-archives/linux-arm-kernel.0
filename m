From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Oct 2010 15:44:41 +0900
Subject: [PATCH V3 1/3] ARM: Add L2X0 PREFETCH and POWER control register
In-Reply-To: <1287643483-16046-1-git-send-email-kgene.kim@samsung.com>
References: <1287643483-16046-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1287643483-16046-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

This patch adds L2X0 Prefetch and Power control register.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 6bcba48..351ca8d 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -53,6 +53,10 @@
 #define L2X0_LINE_DATA			0xF10
 #define L2X0_LINE_TAG			0xF30
 #define L2X0_DEBUG_CTRL			0xF40
+#define L2X0_PREFETCH_CTRL		0xF60
+#define L2X0_POWER_CTRL			0xF80
+#define   L2X0_DYNAMIC_CLK_GATING_EN	(1 << 1)
+#define   L2X0_STNDBY_MODE_EN		(1 << 0)
 
 #ifndef __ASSEMBLY__
 extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
-- 
1.6.2.5
