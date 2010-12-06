From: per.forlin@stericsson.com (Per Forlin)
Date: Mon, 6 Dec 2010 13:52:23 +0100
Subject: [PATCH 1/3] ux500: Call prmcu_init only for u8500
In-Reply-To: <1291639945-2866-1-git-send-email-per.forlin@stericsson.com>
References: <1291639945-2866-1-git-send-email-per.forlin@stericsson.com>
Message-ID: <1291639945-2866-2-git-send-email-per.forlin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Per Forlin <per.forlin@linaro.org>

PRCMU driver only supports u8500. Don't
initialize prcmu if running on u5500.

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 arch/arm/mach-ux500/cpu.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 46c372f..a3700bc 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -59,7 +59,8 @@ void __init ux500_init_irq(void)
 	 * Init clocks here so that they are available for system timer
 	 * initialization.
 	 */
-	prcmu_early_init();
+	if (cpu_is_u8500())
+		prcmu_early_init();
 	clk_init();
 }
 
-- 
1.6.3.3
