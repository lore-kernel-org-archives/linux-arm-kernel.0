From: broonie@kernel.org (Mark Brown)
Date: Tue, 18 Mar 2014 11:56:43 +0000
Subject: [PATCH 2/2] ARM: s3c64xx: Fix build for implicit serial_s3c.h
 inclusion
In-Reply-To: <1395143803-2032-1-git-send-email-broonie@kernel.org>
References: <1395143803-2032-1-git-send-email-broonie@kernel.org>
Message-ID: <1395143803-2032-2-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Some very recent change appears to have removed an implicit inclusion of
serial_s3c.h causing build failures due to references to UART registers
in the serial port restore code in next-20140318.  Include it explicitly
to fix the build.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm/mach-s3c64xx/include/mach/pm-core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-s3c64xx/include/mach/pm-core.h b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
index c0537f40a3d8..a30a1e3ffc6a 100644
--- a/arch/arm/mach-s3c64xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
@@ -15,6 +15,8 @@
 #ifndef __MACH_S3C64XX_PM_CORE_H
 #define __MACH_S3C64XX_PM_CORE_H __FILE__
 
+#include <linux/serial_s3c.h>
+
 #include <mach/regs-gpio.h>
 
 static inline void s3c_pm_debug_init_uart(void)
-- 
1.9.0
