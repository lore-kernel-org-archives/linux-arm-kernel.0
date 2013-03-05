From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 23:16:49 +0100
Subject: [PATCH 9/9] ARM: spear3xx: Use correct pl080 header file
In-Reply-To: <1362521809-22989-1-git-send-email-arnd@arndb.de>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
Message-ID: <1362521809-22989-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definitions have move around recently, causing build errors
in spear3xx for all configurations:

spear3xx.c:47:5: error: 'PL080_BSIZE_16' undeclared here (not in a function)
spear3xx.c:47:23: error: 'PL080_CONTROL_SB_SIZE_SHIFT' undeclared here (not in a function)
spear3xx.c:48:22: error: 'PL080_CONTROL_DB_SIZE_SHIFT' undeclared here (not in a function)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Rubini <rubini@gnudd.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-spear3xx/spear3xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index f9d754f..d2b3937 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -14,7 +14,7 @@
 #define pr_fmt(fmt) "SPEAr3xx: " fmt
 
 #include <linux/amba/pl022.h>
-#include <linux/amba/pl08x.h>
+#include <linux/amba/pl080.h>
 #include <linux/io.h>
 #include <plat/pl080.h>
 #include <mach/generic.h>
-- 
1.8.1.2
