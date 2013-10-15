From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 14 Oct 2013 19:43:43 -0500
Subject: [PATCHv2] arm: socfpga: Enable ARM_TWD for socfpga
Message-ID: <1381797823-4755-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Update SOCFPGA's Kconfig to include building the ARM TWD timer for
SMP use.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
CC: Kevin Hilman <khilman@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-socfpga/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index dd86db4..823de65 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -11,6 +11,7 @@ config ARCH_SOCFPGA
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PL061 if GPIOLIB
 	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
 	select MFD_SYSCON
 	select SPARSE_IRQ
-- 
1.7.9.5
