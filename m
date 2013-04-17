From: olof@lixom.net (Olof Johansson)
Date: Wed, 17 Apr 2013 12:01:42 -0700
Subject: [PATCH] ARM: shmobile: add missing include of of.h
Message-ID: <1366225302-23150-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following build warnings:

In file included from arch/arm/mach-shmobile/setup-r8a7779.c:25:0:
include/linux/of_platform.h:107:13: warning: 'struct of_device_id' declared inside parameter list [enabled by default]
include/linux/of_platform.h:107:13: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
include/linux/of_platform.h:107:13: warning: 'struct device_node' declared inside parameter list [enabled by default]

Signed-off-by: Olof Johansson <olof@lixom.net>
---

Hi Simon,

I'll just apply this directly if it's OK with you?



-Olof

 arch/arm/mach-shmobile/setup-r8a7779.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index b0b3948..7413fc0 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
-- 
1.8.1.192.gc4361b8
