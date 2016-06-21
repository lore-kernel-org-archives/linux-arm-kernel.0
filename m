From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 13:36:46 +0100
Subject: [PATCH] ARM: prima2: make 'sirfsoc_rtc_iobrg_wait_sync' static
Message-ID: <1466512606-3095-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'sirfsoc_rtc_iobrg_wait_sync' function is not exported or used
outside of the rtciobrg.c fle, so fix the following warning by
making it static:

arch/arm/mach-prima2/rtciobrg.c:36:6: warning: symbol 'sirfsoc_rtc_iobrg_wait_sync' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Barry Song <baohua@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-prima2/rtciobrg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-prima2/rtciobrg.c b/arch/arm/mach-prima2/rtciobrg.c
index 89d5f4d3..ae43c86 100644
--- a/arch/arm/mach-prima2/rtciobrg.c
+++ b/arch/arm/mach-prima2/rtciobrg.c
@@ -33,7 +33,7 @@ static DEFINE_SPINLOCK(rtciobrg_lock);
  * symbols without lock are only used by suspend asm codes
  * and these symbols are not exported too
  */
-void sirfsoc_rtc_iobrg_wait_sync(void)
+static void sirfsoc_rtc_iobrg_wait_sync(void)
 {
 	while (readl_relaxed(sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_CTRL))
 		cpu_relax();
-- 
2.8.1
