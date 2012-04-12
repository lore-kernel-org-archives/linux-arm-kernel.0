From: dwalker@fifo99.com (Daniel Walker)
Date: Thu, 12 Apr 2012 08:45:37 -0700
Subject: [PATCH] arm: msm: trout: fix compile failure
Message-ID: <1334245537-13395-1-git-send-email-dwalker@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following warnings,

arch/arm/mach-msm/board-trout.c: In function 'trout_init':
arch/arm/mach-msm/board-trout.c:71: error: 'system_rev' undeclared (first use in this function)
arch/arm/mach-msm/board-trout.c:71: error: (Each undeclared identifier is reported only once
arch/arm/mach-msm/board-trout.c:71: error: for each function it appears in.)

and

arch/arm/mach-msm/board-trout-panel.c: In function 'trout_init_panel':
arch/arm/mach-msm/board-trout-panel.c:267: error: 'system_rev' undeclared (first use in this function)
arch/arm/mach-msm/board-trout-panel.c:267: error: (Each undeclared identifier is reported only once
arch/arm/mach-msm/board-trout-panel.c:267: error: for each function it appears in.)

This came in with the following commit 9f97da78bf018206fb623cd351d454af2f105fe0
which removes asm/system.h

Signed-off-by: Daniel Walker <dwalker@fifo99.com>
cc: David Howells <dhowells@redhat.com>
cc: Bryan Huntsman <bryanh@codeaurora.org>
cc: linux-arm-msm at vger.kernel.org
cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-msm/board-trout-panel.c |    1 +
 arch/arm/mach-msm/board-trout.c       |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-msm/board-trout-panel.c b/arch/arm/mach-msm/board-trout-panel.c
index 25105c1..89bf6b4 100644
--- a/arch/arm/mach-msm/board-trout-panel.c
+++ b/arch/arm/mach-msm/board-trout-panel.c
@@ -12,6 +12,7 @@
 
 #include <asm/io.h>
 #include <asm/mach-types.h>
+#include <asm/system_info.h>
 
 #include <mach/msm_fb.h>
 #include <mach/vreg.h>
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index 5414f76..d4060a3 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/clkdev.h>
 
+#include <asm/system_info.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-- 
1.7.10.130.g36e6c
