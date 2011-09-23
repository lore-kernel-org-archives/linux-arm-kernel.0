From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Sep 2011 15:49:40 +0800
Subject: [PATCH] arm/mxs: PHYS_OFFSET can not be defined in platform any longer
Message-ID: <1316764180-5722-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ARM_PATCH_PHYS_VIRT has been globally enabled by default,
PHYS_OFFSET can not be defined in platform any longer.  Otherwise,
we will run into the following warning.

  arch/arm/include/asm/memory.h:156:0: warning: "PHYS_OFFSET" redefined
  arch/arm/mach-mxs/include/mach/memory.h:22:0: note: this is the location of the previous definition

Change PHYS_OFFSET to PLAT_PHYS_OFFSET to avoid the warning.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Yes, I know that Nicolas has a big patch to remove mach/memory.h
globally.  But rmk has not acked/pulled it.  This patch is posted
just for reminding that if Nicolas' patch does not hit v3.2, we will
have to merge this patch to save a fix patch to remove the warning.

 arch/arm/mach-mxs/include/mach/memory.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/memory.h b/arch/arm/mach-mxs/include/mach/memory.h
index b5420a5..0618ae2 100644
--- a/arch/arm/mach-mxs/include/mach/memory.h
+++ b/arch/arm/mach-mxs/include/mach/memory.h
@@ -19,6 +19,6 @@
 #ifndef __MACH_MXS_MEMORY_H__
 #define __MACH_MXS_MEMORY_H__
 
-#define PHYS_OFFSET		UL(0x40000000)
+#define PLAT_PHYS_OFFSET	UL(0x40000000)
 
 #endif /* __MACH_MXS_MEMORY_H__ */
-- 
1.7.4.1
