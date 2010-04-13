From: Dinh.Nguyen@freescale.com (Dinh.Nguyen at freescale.com)
Date: Tue, 13 Apr 2010 14:05:08 -0500
Subject: [PATCH 2.6.34-rc4 1/1] mx5: Fix build error for mx51_defconfig
Message-ID: <1271185508-7038-1-git-send-email-Dinh.Nguyen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <Dinh.Nguyen@freescale.com>

Need to include <asm/div64.h> for do_div calls.

Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 8f85f73..1ee6ce4 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 
 #include <asm/clkdev.h>
+#include <asm/div64.h>
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-- 
1.6.0.4
