From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Jun 2014 11:53:47 +0200
Subject: [PATCH] serial: samsung: fix typo in debug code
Message-ID: <10455941.RzodM59Z3O@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit e4ac92df2791 ("serial: samsung: Neaten dbg uses") introduced
a regression in the conversion from vsprintf to vsnprintf.

This fixes the build error by passing the correct variable name.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 3293377..c1d3ebd 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -66,7 +66,7 @@ static void dbg(const char *fmt, ...)
 	char buff[256];
 
 	va_start(va, fmt);
-	vscnprintf(buff, sizeof(buf), fmt, va);
+	vscnprintf(buff, sizeof(buff), fmt, va);
 	va_end(va);
 
 	printascii(buff);
