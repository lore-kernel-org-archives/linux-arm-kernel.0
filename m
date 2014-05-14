From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 May 2014 03:10:16 +0200
Subject: [PATCH v6 12/12] ARM: shmobile: Add forward declaration of struct clk
 to silence warning
In-Reply-To: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
References: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1400029816-24028-13-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

arch/arm/mach-shmobile/board-genmai-reference.c:23:0:
arch/arm/mach-shmobile/include/mach/clock.h:19:54: warning: 'struct clk' declared inside parameter list [enabled by default]
arch/arm/mach-shmobile/include/mach/clock.h:19:54: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/mach-shmobile/include/mach/clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/include/mach/clock.h b/arch/arm/mach-shmobile/include/mach/clock.h
index 9a93cf924b9c..31b6417463e6 100644
--- a/arch/arm/mach-shmobile/include/mach/clock.h
+++ b/arch/arm/mach-shmobile/include/mach/clock.h
@@ -16,6 +16,7 @@ void shmobile_clk_workaround(const struct clk_name *clks, int nr_clks,
 #else /* CONFIG_COMMON_CLK */
 /* legacy clock implementation */
 
+struct clk;
 unsigned long shmobile_fixed_ratio_clk_recalc(struct clk *clk);
 extern struct sh_clk_ops shmobile_fixed_ratio_clk_ops;
 
-- 
1.9.2
