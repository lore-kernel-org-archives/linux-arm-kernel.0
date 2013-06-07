From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  7 Jun 2013 13:47:38 -0300
Subject: [PATCH 01/14] bus: mvebu-mbus: Use pr_fmt
In-Reply-To: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1370623671-7748-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to clean message printing, we replace pr_info with pr_fmt.
This is purely cosmetic change, with the sole purpose of making
the code a bit more readable.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 8740f46..33c6947 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -49,6 +49,8 @@
  *   configuration (file 'devices').
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -762,7 +764,7 @@ int mvebu_mbus_add_window_remap_flags(const char *devname, phys_addr_t base,
 			break;
 
 	if (!s->soc->map[i].name) {
-		pr_err("mvebu-mbus: unknown device '%s'\n", devname);
+		pr_err("unknown device '%s'\n", devname);
 		return -ENODEV;
 	}
 
@@ -775,7 +777,7 @@ int mvebu_mbus_add_window_remap_flags(const char *devname, phys_addr_t base,
 		attr |= 0x28;
 
 	if (!mvebu_mbus_window_conflicts(s, base, size, target, attr)) {
-		pr_err("mvebu-mbus: cannot add window '%s', conflicts with another window\n",
+		pr_err("cannot add window '%s', conflicts with another window\n",
 		       devname);
 		return -EINVAL;
 	}
@@ -842,7 +844,7 @@ int __init mvebu_mbus_init(const char *soc, phys_addr_t mbuswins_phys_base,
 			break;
 
 	if (!of_id->compatible) {
-		pr_err("mvebu-mbus: could not find a matching SoC family\n");
+		pr_err("could not find a matching SoC family\n");
 		return -ENODEV;
 	}
 
-- 
1.8.1.5
