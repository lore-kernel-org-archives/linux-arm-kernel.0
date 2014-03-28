From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:19:48 +0000
Subject: [PATCH 63/75] ARM: l2c: zynq: remove cache size override
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYZQ-0007H7-L6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-zynq/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 8c09a8393fb6..b58f17178006 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -67,7 +67,7 @@ static void __init zynq_init_machine(void)
 	/*
 	 * 64KB way size, 8-way associativity, parity disabled
 	 */
-	l2x0_of_init(0x02060000, 0xF0F0FFFF);
+	l2x0_of_init(0x02000000, 0xf0ffffff);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-- 
1.8.3.1
