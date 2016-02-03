From: joshc@ni.com (Josh Cartwright)
Date: Tue, 2 Feb 2016 20:30:48 -0600
Subject: [PATCH 1/2] ARM: zynq: initialize slcr mapping earlier
In-Reply-To: <cover.1454465714.git.joshc@ni.com>
References: <cover.1454465714.git.joshc@ni.com>
Message-ID: <7ae1c16ab8807d797cf6a742f33cae571c879c6f.1454465714.git.joshc@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for performing additional configuration prior to bringing
up L2, move the slcr initialization earlier in the boot process.

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 arch/arm/mach-zynq/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 6f39d03..860ffb6 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -150,8 +150,6 @@ out:
 
 static void __init zynq_timer_init(void)
 {
-	zynq_early_slcr_init();
-
 	zynq_clock_init();
 	of_clk_init(NULL);
 	clocksource_probe();
@@ -186,6 +184,7 @@ static void __init zynq_map_io(void)
 
 static void __init zynq_irq_init(void)
 {
+	zynq_early_slcr_init();
 	irqchip_init();
 }
 
-- 
2.7.0
