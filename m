From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 26 Oct 2012 16:17:41 -0600
Subject: [PATCH] arm: socfpga: fix build break for allyesconfig
Message-ID: <1351289861-16297-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Add check for armv7 in headsmp.S.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/mach-socfpga/headsmp.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index 17d6eaf..9031a3c 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -15,8 +15,10 @@
 #define CPU1_START_ADDR 	        0xffd08010
 
 ENTRY(secondary_trampoline)
+#if __LINUX_ARM_ARCH__ >= 7
 	movw	r0, #:lower16:CPU1_START_ADDR
 	movt  r0, #:upper16:CPU1_START_ADDR
+#endif
 
 	ldr	r1, [r0]
 	bx	r1
-- 
1.7.9.5
