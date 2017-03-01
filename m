From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Wed,  1 Mar 2017 15:26:01 +0300
Subject: [PATCH] Revert "tty: serial: pl011: add ttyAMA for matching pl011
 console"
Message-ID: <20170301122602.30025-1-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original patch makes condition always true, so it is wrong.

This reverts commit aea9a80ba98a0c9b4de88850260e9fbdcc98360b.
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8789ea423ccf..56f92d7348bf 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2373,7 +2373,7 @@ static int __init pl011_console_match(struct console *co, char *name, int idx,
 	if (strcmp(name, "qdf2400_e44") == 0) {
 		pr_info_once("UART: Working around QDF2400 SoC erratum 44");
 		qdf2400_e44_present = true;
-	} else if (strcmp(name, "pl011") != 0 || strcmp(name, "ttyAMA") != 0) {
+	} else if (strcmp(name, "pl011") != 0) {
 		return -ENODEV;
 	}
 
-- 
2.11.1
