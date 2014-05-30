From: riku.voipio@linaro.org (Riku Voipio)
Date: Fri, 30 May 2014 15:28:19 +0300
Subject: =?UTF-8?q?=5BPATCH=5D=20thermal=3A=20allow=20building=20dove=5Fthermal=20with=20mvebu?=
Message-ID: <1401452899-13952-1-git-send-email-riku.voipio@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT-enabled Dove has moved from ARCH_DOVE in mach-dove to MACH_DOVE
in mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
DT-only MACH_DOVE to thermal Kconfig.

This was originally supposed to go in via "ARM: dove: prepare new Dove DT Kconfig"
patch from Sebastian Hesselbarth for 3.15, but slipped through the cracks.

I've tested on CuBox that without this patch you can't compile
dove_thermal into a mach-mvebu based kernel, and with this patch I can
build the driver and it works as expected run-time.

Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2d51912..5783c72 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -151,7 +151,7 @@ config KIRKWOOD_THERMAL
 
 config DOVE_THERMAL
 	tristate "Temperature sensor on Marvell Dove SoCs"
-	depends on ARCH_DOVE
+	depends on ARCH_DOVE ||?MACH_DOVE
 	depends on OF
 	help
 	  Support for the Dove thermal sensor driver in the Linux thermal
-- 
2.0.0.rc2
