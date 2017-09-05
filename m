From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Sep 2017 10:19:55 +0200
Subject: [PATCH] drm: exynos: include linux/irq.h
Message-ID: <20170905082022.1239056-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I ran into a build error on x86:

drivers/gpu/drm/exynos/exynos5433_drm_decon.c: In function 'decon_conf_irq':
drivers/gpu/drm/exynos/exynos5433_drm_decon.c:706:2: error: implicit declaration of function 'irq_set_status_flags'; did you mean 'dquot_state_flag'? [-Werror=implicit-function-declaration]
  irq_set_status_flags(irq, IRQ_NOAUTOEN);

Adding the missing include fixes the error.

Fixes: b37d53a0382c ("drm/exynos/decon5433: move TE handling to DECON")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 730b8d9db187..6be5b53c3b27 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/iopoll.h>
+#include <linux/irq.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
-- 
2.9.0
