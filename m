From: dianders@chromium.org (Douglas Anderson)
Date: Tue, 30 Oct 2018 15:11:06 -0700
Subject: [PATCH v2 4/5] serial: core: Include console.h from serial_core.h
In-Reply-To: <20181030221107.79758-1-dianders@chromium.org>
References: <20181030221107.79758-1-dianders@chromium.org>
Message-ID: <20181030221107.79758-5-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the static inline function uart_handle_break() in serial_core.h we
dereference port->cons.  That gives an error unless console.h is also
included.

This error hasn't shown up till now because everyone who has defined
SUPPORT_SYSRQ has also included console.h, but it's a bit ugly to make
this requirement.  Let's make the include explicit.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/serial_core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3460b15a2607..ff9d0ee32f11 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -22,6 +22,7 @@
 
 #include <linux/bitops.h>
 #include <linux/compiler.h>
+#include <linux/console.h>
 #include <linux/interrupt.h>
 #include <linux/circ_buf.h>
 #include <linux/spinlock.h>
-- 
2.19.1.568.g152ad8e336-goog
