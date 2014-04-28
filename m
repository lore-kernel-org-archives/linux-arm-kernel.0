From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:33:16 +0100
Subject: [PATCH 83/97] ARM: l2c: imx: remove direct write to power control
 register
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerIi-0001ZL-2w@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we handle this in core code, we don't need platforms enabling
the low power modes directly.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
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
