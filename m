From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  4 Feb 2014 16:58:42 +0100
Subject: [PATCH 01/17] amba: Let runtime PM callbacks be available for
 CONFIG_PM
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1391529538-21685-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert to the SET_PM_RUNTIME_PM macro while defining the runtime PM
callbacks. This means the callbacks becomes available for both
CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME, which is needed by drivers and
power domains.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 9e60291..3cf61a1 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -83,7 +83,7 @@ static struct device_attribute amba_dev_attrs[] = {
 	__ATTR_NULL,
 };
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 /*
  * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
  * enable/disable the bus clock at runtime PM suspend/resume as this
@@ -123,7 +123,7 @@ static const struct dev_pm_ops amba_pm = {
 	.thaw		= pm_generic_thaw,
 	.poweroff	= pm_generic_poweroff,
 	.restore	= pm_generic_restore,
-	SET_RUNTIME_PM_OPS(
+	SET_PM_RUNTIME_PM_OPS(
 		amba_pm_runtime_suspend,
 		amba_pm_runtime_resume,
 		NULL
-- 
1.7.9.5
