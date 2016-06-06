From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  6 Jun 2016 18:41:01 +0900
Subject: [PATCH 2/4] serial: 8250_uniphier: drop !defined(MODULE) conditional
In-Reply-To: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1465206063-1018-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The !defined(MODULE) conditional has been added to the
OF_EARLYCON_DECLARE() define.

Now we can revert commit a2d3ea2f2399 ("serial: 8250/uniphier:
fix modular build").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index efd1f9c..b8d9c8c 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -35,7 +35,7 @@ struct uniphier8250_priv {
 	spinlock_t atomic_write_lock;
 };
 
-#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
+#ifdef CONFIG_SERIAL_8250_CONSOLE
 static int __init uniphier_early_console_setup(struct earlycon_device *device,
 					       const char *options)
 {
-- 
1.9.1
