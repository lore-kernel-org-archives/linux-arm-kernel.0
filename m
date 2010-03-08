From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Mon, 08 Mar 2010 11:15:30 +0000
Subject: [PATCH] pxa: fix for UART reference in section text for a number
	of platforms.
Message-ID: <4B94DC52.1040201@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

---
 Fix exactly as proposed by Russell King.  Thanks!

 arch/arm/mach-pxa/include/mach/uncompress.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
index 237734b..b009299 100644
--- a/arch/arm/mach-pxa/include/mach/uncompress.h
+++ b/arch/arm/mach-pxa/include/mach/uncompress.h
@@ -15,7 +15,7 @@
 
 #define __REG(x)       ((volatile unsigned long *)x)
 
-static volatile unsigned long *UART = FFUART;
+static volatile unsigned long *UART;
 
 static inline void putc(char c)
 {
@@ -39,6 +39,8 @@ static inline void arch_decomp_setup(void)
 	    || machine_is_csb726() || machine_is_stargate2()
 	    || machine_is_cm_x300() || machine_is_balloon3())
 		UART = STUART;
+	else
+		UART = FFUART;
 }
 
 /*
-- 
1.6.4.4
