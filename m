From: leochen@broadcom.com (Leo (Hao) Chen)
Date: Mon, 7 Dec 2009 18:39:29 -0800
Subject: [PATCH] Bcmring: fix build error with bcmring_defconfig
Message-ID: <20091208023929.GP26191@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This patch is to fix the build error with bcmring_defconfig.

The error is caught by KAutoBuild.

/var/tmp/kernel-orig/usr/include/linux/perf_event.h:22: included file
'asm-arm/hw_breakpoint.h' is not exported
make[3]: *** [/var/tmp/kernel-orig/usr/include/linux/.check] Error 123
make[2]: *** [linux] Error 2
make[1]: *** [headers_check] Error 2
make: *** [vmlinux] Error 2
make: Leaving directory `/var/tmp/kernel-orig'

From: Leo Chen <leochen@broadcom.com>
Date: Mon, 7 Dec 2009 18:36:58 -0800
Subject: [PATCH] disable header check to fix build error of bcmring_defconfig


Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
---
 arch/arm/configs/bcmring_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/bcmring_defconfig b/arch/arm/configs/bcmring_defconfig
index bcc0bac..04b063b 100644
--- a/arch/arm/configs/bcmring_defconfig
+++ b/arch/arm/configs/bcmring_defconfig
@@ -678,7 +678,7 @@ CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
-CONFIG_HEADERS_CHECK=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_MEMORY_INIT is not set
-- 
1.6.0.6

-- 

Leo Hao Chen
