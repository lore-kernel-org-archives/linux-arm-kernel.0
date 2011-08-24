From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 24 Aug 2011 11:23:46 +0200
Subject: [PATCH 2/3] mach-ux500: initialize l2x0 at arch_init time
Message-ID: <1314177826-19151-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

mach-imx initialize their l2x0 cach at arch_init time, so
why shouldn't we.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cache-l2x0.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 9d09e4d..aa2d77f 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -69,4 +69,4 @@ static int ux500_l2x0_init(void)
 	return 0;
 }
 
-early_initcall(ux500_l2x0_init);
+arch_initcall(ux500_l2x0_init);
-- 
1.7.3.2
