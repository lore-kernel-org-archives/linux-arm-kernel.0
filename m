From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Jul 2015 15:35:56 +0200
Subject: [PATCH 1/2] ARM: ux500: move ASIC ID remap to ITCM area
Message-ID: <1438263356-29705-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ux500 does not have ITCM memory so we can remap the ASIC ID
at 0xfffe0000 to get that remap out of the vmalloc area.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/db8500-regs.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/db8500-regs.h b/arch/arm/mach-ux500/db8500-regs.h
index 27399553c841..65b7a689374c 100644
--- a/arch/arm/mach-ux500/db8500-regs.h
+++ b/arch/arm/mach-ux500/db8500-regs.h
@@ -182,8 +182,11 @@
  */
 #define U8500_IO_VIRTUAL	0xf0000000
 #define U8500_IO_PHYSICAL	0xa0000000
-/* This is where we map in the ROM to check ASIC IDs */
-#define UX500_VIRT_ROM		IOMEM(0xf0000000)
+/*
+ * This is where we map in the ROM to check ASIC IDs, as the Ux500s
+ * do not have TCM memory, we can reuse the ITCM reserved area.
+ */
+#define UX500_VIRT_ROM		IOMEM(0xfffe0000)
 
 /* This macro is used in assembly, so no cast */
 #define IO_ADDRESS(x)           \
-- 
2.4.3
