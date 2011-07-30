From: zdevai@gmail.com (Zoltan Devai)
Date: Sat, 30 Jul 2011 18:21:05 +0200
Subject: [PATCH] ARM: Do not write to read-only register of VIC
Message-ID: <1312042865-26062-1-git-send-email-zdevai@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This causes an external abort on at least one platform.

Signed-off-by: Zoltan Devai <zdevai@gmail.com>
---
 arch/arm/common/vic.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 7aa4262..197f81c 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -259,7 +259,6 @@ static void __init vic_disable(void __iomem *base)
 	writel(0, base + VIC_INT_SELECT);
 	writel(0, base + VIC_INT_ENABLE);
 	writel(~0, base + VIC_INT_ENABLE_CLEAR);
-	writel(0, base + VIC_IRQ_STATUS);
 	writel(0, base + VIC_ITCR);
 	writel(~0, base + VIC_INT_SOFT_CLEAR);
 }
-- 
1.7.4.1
