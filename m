From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 23:02:52 +0200
Subject: [PATCH 3/9] ARM: imx: build CPU suspend code only when needed
In-Reply-To: <1367528578-518090-1-git-send-email-arnd@arndb.de>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
Message-ID: <1367528578-518090-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM CPU suspend function has its own configuration symbol,
which we need to use for conditionalizing any code calling into
it as well.

arch/arm/mach-imx/built-in.o: In function `v7_cpu_resume':
/git/arm-soc/arch/arm/mach-imx/headsmp.S:57: undefined
 reference to `cpu_resume'

Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/headsmp.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index a58c8b0..67b9c48 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -24,7 +24,7 @@ ENTRY(v7_secondary_startup)
 ENDPROC(v7_secondary_startup)
 #endif
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_ARM_CPU_SUSPEND
 /*
  * The following code must assume it is running from physical address
  * where absolute virtual addresses to the data section have to be
-- 
1.8.1.2
