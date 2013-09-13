From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 12:53:49 +0200
Subject: [PATCH 5/6] input: i8042: drop dependency on ARCH_SHARK
Message-ID: <1379069629-4231-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Delete the configuration option for the Shark machine from
the i8042 Kconfig, as the machine is deleted from the kernel.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/serio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 1e691a3..90832fa 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -21,7 +21,7 @@ if SERIO
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EXPERT || !X86
 	default y
-	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && \
+	depends on !PARISC && (!ARM || FOOTBRIDGE_HOST) && \
 		   (!SUPERH || SH_CAYMAN) && !M68K && !BLACKFIN && !S390 && \
 		   !ARC
 	help
-- 
1.8.3.1
