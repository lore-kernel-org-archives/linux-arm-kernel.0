From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:20:50 +0000
Subject: [PATCH 75/75] ARM: l2c: imx: remove direct write to power control
 register
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYaQ-0007I4-0D@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we handle this in core code, we don't need platforms enabling
the low power modes directly.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-imx/system.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 59013a81107b..3b0733edb68c 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -138,8 +138,6 @@ void __init imx_init_l2cache(void)
 	if (cpu_is_imx6q())
 		val &= ~(1 << 30 | 1 << 23);
 	writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
-	val = L310_DYNAMIC_CLK_GATING_EN | L310_STNDBY_MODE_EN;
-	writel_relaxed(val, l2x0_base + L310_POWER_CTRL);
 
 	iounmap(l2x0_base);
 	of_node_put(np);
-- 
1.8.3.1
