From: edubezval@gmail.com (Eduardo Valentin)
Date: Sun, 13 Sep 2015 19:31:32 -0700
Subject: [PATCHv2 03/10] thermal: rockchip: allow compile test
In-Reply-To: <1442197899-5952-1-git-send-email-edubezval@gmail.com>
References: <1442197899-5952-1-git-send-email-edubezval@gmail.com>
Message-ID: <1442197899-5952-4-git-send-email-edubezval@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding COMPILE_TEST flag to rockchip driver to facilitate
maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0334886..2e0aaee 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -190,7 +190,7 @@ config SPEAR_THERMAL
 
 config ROCKCHIP_THERMAL
 	tristate "Rockchip thermal driver"
-	depends on ARCH_ROCKCHIP
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on RESET_CONTROLLER
 	help
 	  Rockchip thermal driver provides support for Temperature sensor
-- 
2.5.0
