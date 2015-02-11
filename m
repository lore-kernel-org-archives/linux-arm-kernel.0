From: vbridger@opensource.altera.com (Vince Bridgers)
Date: Wed, 11 Feb 2015 12:34:25 -0600
Subject: [PATCH] arm: socfpga: Correct SCU virtual mapping in socfpga
Message-ID: <1423679665-19545-1-git-send-email-vbridger@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct SCU virtual mapping that was causing this BUG message:

"BUG: mapping for 0xfffec000 at 0xfffec000 out of vmalloc space"

Signed-off-by: Vince Bridgers <vbridger@opensource.altera.com>
---
 arch/arm/mach-socfpga/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 483cb46..a0f3b1c 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -45,6 +45,6 @@ extern char secondary_trampoline, secondary_trampoline_end;
 
 extern unsigned long socfpga_cpu1start_addr;
 
-#define SOCFPGA_SCU_VIRT_BASE   0xfffec000
+#define SOCFPGA_SCU_VIRT_BASE   0xfee00000
 
 #endif
-- 
1.9.1
