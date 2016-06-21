From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 13:43:40 +0100
Subject: [PATCH] ARM: prima2: fix missing <linux/rtc/sirfsoc_rtciobrg.h> in
 rtciobrg.c
Message-ID: <1466513020-21334-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header file <linux/rtc/sirfsoc_rtciobrg.h> declares two functions
exported from the rtciobrg.c file, so include it to fix the following
warnings:

arch/arm/mach-prima2/rtciobrg.c:41:6: warning: symbol 'sirfsoc_rtc_iobrg_besyncing' was not declared. Should it be static?
arch/arm/mach-prima2/rtciobrg.c:91:6: warning: symbol 'sirfsoc_rtc_iobrg_writel' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Barry Song <baohua@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-prima2/rtciobrg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-prima2/rtciobrg.c b/arch/arm/mach-prima2/rtciobrg.c
index d4852d2..89d5f4d3 100644
--- a/arch/arm/mach-prima2/rtciobrg.c
+++ b/arch/arm/mach-prima2/rtciobrg.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
+#include <linux/rtc/sirfsoc_rtciobrg.h>
 
 #define SIRFSOC_CPUIOBRG_CTRL           0x00
 #define SIRFSOC_CPUIOBRG_WRBE           0x04
-- 
2.8.1
