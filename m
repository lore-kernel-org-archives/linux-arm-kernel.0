From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:36 +0900
Subject: [PATCH 11/12] ARM: shmobile: Add forward declaration of struct clk to
 silence warning
In-Reply-To: <cover.1400201383.git.horms+renesas@verge.net.au>
References: <cover.1400201383.git.horms+renesas@verge.net.au>
Message-ID: <1f9c7a691fefc2158bed4d5403422cc9b99ca335.1400201383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

arch/arm/mach-shmobile/board-genmai-reference.c:23:0:
arch/arm/mach-shmobile/include/mach/clock.h:19:54: warning: 'struct clk' declared inside parameter list [enabled by default]
arch/arm/mach-shmobile/include/mach/clock.h:19:54: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/include/mach/clock.h b/arch/arm/mach-shmobile/include/mach/clock.h
index 9a93cf9..31b6417 100644
--- a/arch/arm/mach-shmobile/include/mach/clock.h
+++ b/arch/arm/mach-shmobile/include/mach/clock.h
@@ -16,6 +16,7 @@ void shmobile_clk_workaround(const struct clk_name *clks, int nr_clks,
 #else /* CONFIG_COMMON_CLK */
 /* legacy clock implementation */
 
+struct clk;
 unsigned long shmobile_fixed_ratio_clk_recalc(struct clk *clk);
 extern struct sh_clk_ops shmobile_fixed_ratio_clk_ops;
 
-- 
1.8.5.2
