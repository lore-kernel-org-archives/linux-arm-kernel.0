From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 31 Aug 2016 16:50:16 +0800
Subject: [PATCH 2/3] thermal: hisilicon: fix for dependency
In-Reply-To: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
References: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1472633417-9330-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thermal driver is standalone driver which is used to enable
thermal sensors, so it can be used with any cooling device and
should not bind with CPU cooling device driver.

This original patch is suggested by Amit Kucheria; so it's to
polish the dependency in Kconfig, and remove the dependency with
CPU_THERMAL.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2d702ca..91ebab3 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -177,8 +177,10 @@ config THERMAL_EMULATION
 
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
-	depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
+	depends on ARCH_HISI || COMPILE_TEST
 	depends on HAS_IOMEM
+	depends on OF
+	default y
 	help
 	  Enable this to plug hisilicon's thermal sensor driver into the Linux
 	  thermal framework. cpufreq is used as the cooling device to throttle
-- 
1.9.1
