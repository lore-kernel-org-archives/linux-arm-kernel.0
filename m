From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 03:35:52 +0100
Subject: [PATCH 01/15] ARM: S3C: Add S3C2416 detection to uncompress code
Message-ID: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yauhen Kharuzhy <jekhor@gmail.com>

Add S3C2416 serial port setup to uncompress code.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/include/mach/uncompress.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/uncompress.h b/arch/arm/mach-s3c2410/include/mach/uncompress.h
index 72f756c..8b283f8 100644
--- a/arch/arm/mach-s3c2410/include/mach/uncompress.h
+++ b/arch/arm/mach-s3c2410/include/mach/uncompress.h
@@ -40,7 +40,9 @@ static void arch_detect_cpu(void)
 	cpuid &= S3C2410_GSTATUS1_IDMASK;
 
 	if (is_arm926() || cpuid == S3C2410_GSTATUS1_2440 ||
-	    cpuid == S3C2410_GSTATUS1_2442) {
+	    cpuid == S3C2410_GSTATUS1_2442 ||
+	    cpuid == S3C2410_GSTATUS1_2416 ||
+	    cpuid == S3C2410_GSTATUS1_2450) {
 		fifo_mask = S3C2440_UFSTAT_TXMASK;
 		fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
 	} else {
-- 
1.6.3.3
