From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  1 Jul 2014 11:33:15 +0200
Subject: [PATCH v2 02/14] AT91: generic.h: Add include safe guards
In-Reply-To: <1404207208-14513-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1404207208-14513-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1404207208-14513-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic.h header file doesn't have any safe guards against multiple
inclusion. It only worked so far because all the symbols defined in it were
extern, but this is a rather fragile assumption.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/generic.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 631fa3b8c16d..77d4daeee66a 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -8,6 +8,9 @@
  * published by the Free Software Foundation.
  */
 
+#ifndef _AT91_GENERIC_H
+#define _AT91_GENERIC_H
+
 #include <linux/clkdev.h>
 #include <linux/of.h>
 #include <linux/reboot.h>
@@ -90,3 +93,5 @@ extern int  __init at91_gpio_of_irq_setup(struct device_node *node,
 					  struct device_node *parent);
 
 extern u32 at91_get_extern_irq(void);
+
+#endif /* _AT91_GENERIC_H */
-- 
2.0.0
