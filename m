From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Aug 2012 20:27:12 +0200
Subject: [PATCH 3/4] ARM: ks8695: delete resume hook from timer
Message-ID: <1346264832-20379-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This system does not support suspend/resume so let's skip this
hook altogether.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ks8695/time.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ks8695/time.c b/arch/arm/mach-ks8695/time.c
index ae9dacc..6974c23 100644
--- a/arch/arm/mach-ks8695/time.c
+++ b/arch/arm/mach-ks8695/time.c
@@ -127,7 +127,6 @@ static void __init ks8695_timer_init (void)
 struct sys_timer ks8695_timer = {
 	.init		= ks8695_timer_init,
 	.offset		= ks8695_gettimeoffset,
-	.resume		= ks8695_timer_setup,
 };
 
 void ks8695_restart(char mode, const char *cmd)
-- 
1.7.7.6
