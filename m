From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 21 Jan 2013 18:25:18 +0800
Subject: [PATCH] ARM: plat-samsung: using vsnprintf instead of vsprintf for
 the limit buffer length 256
Message-ID: <50FD178E.9090105@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  the buff size is 256, so need use vsnprintf instead of vsprintf.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/plat-samsung/pm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 1507028..8d07b45 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -51,7 +51,7 @@ void s3c_pm_dbg(const char *fmt, ...)
 	char buff[256];
 
 	va_start(va, fmt);
-	vsprintf(buff, fmt, va);
+	vsnprintf(buff, 256, fmt, va);
 	va_end(va);
 
 	printascii(buff);
-- 
1.7.10.4
