From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:35:37 +0100
Subject: [PATCH 055/222] ARM: l2c: cns3xxx: remove cache size override
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdePp-0007Gp-VG@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-cns3xxx/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 5c31b2638c01..f85449a6accd 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -290,7 +290,7 @@ void __init cns3xxx_l2x0_init(void)
 	writel(val, base + L310_DATA_LATENCY_CTRL);
 
 	/* 32 KiB, 8-way, parity disable */
-	l2x0_init(base, 0x00540000, 0xfe000fff);
+	l2x0_init(base, 0x00500000, 0xfe0f0fff);
 }
 
 #endif /* CONFIG_CACHE_L2X0 */
-- 
1.8.3.1
