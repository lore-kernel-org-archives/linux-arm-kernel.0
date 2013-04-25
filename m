From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 19:28:47 +0200
Subject: [PATCH 04/21] ARM: orion5x: include linux/cpu.h
In-Reply-To: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
Message-ID: <1366910944-3033663-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The linux/cpu.h header is no longer implictly included in this
file, so we need to an #include statement to avoid this build
warning:

arch/arm/mach-orion5x/common.c:339:3: error: implicit declaration of function 'cpu_idle_poll_ctrl' [-Werror=implicit-function-declaration]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-orion5x/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 664c97d..b97fd67 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -19,6 +19,7 @@
 #include <linux/ata_platform.h>
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
+#include <linux/cpu.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/setup.h>
-- 
1.8.1.2
