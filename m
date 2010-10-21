From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Thu, 21 Oct 2010 18:54:27 -0000
Subject: [PATCH 3/4] ARM: S3C64XX: Add suspend support to SmartQ boards
In-Reply-To: <cover.1287681256.git.mcuelenaere@gmail.com>
References: <cover.1287681256.git.mcuelenaere@gmail.com>
Message-ID: <d5c7378119eb72058fb2bae0999e0a886203adaf.1287681256.git.mcuelenaere@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only missing thing for suspend support on SmartQ boards, is a call to
s3c_pm_init, so add that. This was tested on a S3C6410 SmartQ 7.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-smartq.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 3a9639b..0f59a5c 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -32,6 +32,7 @@
 #include <plat/iic.h>
 #include <plat/gpio-cfg.h>
 #include <plat/hwmon.h>
+#include <plat/pm.h>
 #include <plat/regs-serial.h>
 #include <plat/udc-hs.h>
 #include <plat/usb-control.h>
@@ -380,6 +381,9 @@ void __init smartq_map_io(void)
 
 void __init smartq_machine_init(void)
 {
+	/* enable suspend support */
+	s3c_pm_init();
+
 	s3c_i2c0_set_platdata(NULL);
 	s3c_hwmon_set_platdata(&smartq_hwmon_pdata);
 	s3c_sdhci1_set_platdata(&smartq_internal_hsmmc_pdata);
-- 
1.7.2.3
