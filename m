From: zoss@devai.org (Zoltan Devai)
Date: Sun,  9 Oct 2011 18:36:04 +0200
Subject: [PATCH 1/9] ARM: vic: Don't write to the read-only register
	VIC_IRQ_STATUS
In-Reply-To: <1318178172-7965-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
Message-ID: <1318178172-7965-2-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is unneeded and causes an abort on the SPMP8000 platform.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/common/vic.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index b22b83d..651c77d 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -274,7 +274,6 @@ static void __init vic_disable(void __iomem *base)
 	writel(0, base + VIC_INT_SELECT);
 	writel(0, base + VIC_INT_ENABLE);
 	writel(~0, base + VIC_INT_ENABLE_CLEAR);
-	writel(0, base + VIC_IRQ_STATUS);
 	writel(0, base + VIC_ITCR);
 	writel(~0, base + VIC_INT_SOFT_CLEAR);
 }
-- 
1.7.4.1
