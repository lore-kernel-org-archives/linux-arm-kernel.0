From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 23:26:51 +0100
Subject: [PATCH 2/9] fb/exynos: include platform_device.h
In-Reply-To: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
Message-ID: <1360880818-4071454-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 16559ae "kgdb: remove #include <linux/serial_8250.h> from kgdb.h"
removed an implicit inclusion of linux/platform_device.h
from the exynos framebuffer driver. This adds back the required
explicit header file inclusions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ajay Kumar <ajaykumar.rs@samsung.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/exynos/exynos_mipi_dsi_common.c   | 1 +
 drivers/video/exynos/exynos_mipi_dsi_lowlevel.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c b/drivers/video/exynos/exynos_mipi_dsi_common.c
index 3cd29a4..c70cb89 100644
--- a/drivers/video/exynos/exynos_mipi_dsi_common.c
+++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/memory.h>
 #include <linux/delay.h>
+#include <linux/irqreturn.h>
 #include <linux/kthread.h>
 
 #include <video/mipi_display.h>
diff --git a/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c b/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
index 0ef38ce..95cb99a 100644
--- a/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
+++ b/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
@@ -21,6 +21,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/ctype.h>
+#include <linux/platform_device.h>
 #include <linux/io.h>
 
 #include <video/exynos_mipi_dsim.h>
-- 
1.8.1.2
