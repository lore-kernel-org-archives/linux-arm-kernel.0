From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  6 Jun 2016 18:41:02 +0900
Subject: [PATCH 3/4] serial: 8250_mtk: drop !defined(MODULE) conditional
In-Reply-To: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1465206063-1018-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The !defined(MODULE) conditional has been added to the
OF_EARLYCON_DECLARE() define.

This commit partially reverts commit 3f5921a60f74 ("serial:
8250/mediatek: fix building with SERIAL_8250=m").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 3489fbc..3611ec9 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -301,7 +301,7 @@ static struct platform_driver mtk8250_platform_driver = {
 };
 module_platform_driver(mtk8250_platform_driver);
 
-#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
+#ifdef CONFIG_SERIAL_8250_CONSOLE
 static int __init early_mtk8250_setup(struct earlycon_device *device,
 					const char *options)
 {
-- 
1.9.1
