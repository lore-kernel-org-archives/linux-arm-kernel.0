From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 17 Sep 2013 11:21:40 -0500
Subject: [PATCH] arm: socfpga: Enable ARM_TWD for socfpga
Message-ID: <1379434900-24947-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Update Kconfig to enable TWD.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Pavel Machek <pavel@denx.de>
Cc: linux-arm-kernel at lists.infradead.org
---
v2:
- Remove condition of LOCAL_TIMERS for ARM_TWD
---
 arch/arm/mach-socfpga/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index dd86db4..dae9400 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -11,6 +11,7 @@ config ARCH_SOCFPGA
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PL061 if GPIOLIB
 	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
 	select HAVE_SMP
 	select MFD_SYSCON
 	select SPARSE_IRQ
-- 
1.7.9.5
