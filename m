From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jan 2012 11:37:33 +0100
Subject: [PATCH] clps711x: fix compilation breakage
Message-ID: <1325673453-22278-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The restart patches defined a new restart function in common.c
but it needs to be declared in common.h to compile properly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-clps711x/common.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x/common.h
index 2b8b801..fc0f065 100644
--- a/arch/arm/mach-clps711x/common.h
+++ b/arch/arm/mach-clps711x/common.h
@@ -9,3 +9,4 @@ struct sys_timer;
 extern void clps711x_map_io(void);
 extern void clps711x_init_irq(void);
 extern struct sys_timer clps711x_timer;
+extern void clps711x_restart(char mode, const char *cmd);
-- 
1.7.6.4
