From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:19:07 +0000
Subject: [PATCH 55/75] ARM: l2c: cns3xxx: remove cache size override
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYYl-0007Ga-Oe@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-cns3xxx/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index dd2b9926a76c..bce1d36d0ffb 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -258,7 +258,7 @@ void __init cns3xxx_l2x0_init(void)
 	writel(val, base + L310_DATA_LATENCY_CTRL);
 
 	/* 32 KiB, 8-way, parity disable */
-	l2x0_init(base, 0x00540000, 0xfe000fff);
+	l2x0_init(base, 0x00500000, 0xfe0f0fff);
 }
 
 #endif /* CONFIG_CACHE_L2X0 */
-- 
1.8.3.1
