From: balbi@ti.com (Felipe Balbi)
Date: Fri, 30 Jan 2015 11:18:56 -0600
Subject: [PATCH] arm: config: omap2plus_defconfig: switch over to LZMA
 compression
Message-ID: <1422638336-24243-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LZMA compression makes about 33% smaller zImage
with just a slight extra decompression time.

Before this patch, zImage built with o2+_dc
is 4.5MiB and after it's about 3.3MiB.

Suggested-by: David Cohen <david.a.cohen@linux.intel.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b7386524c356..742c62b6d663 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -1,3 +1,4 @@
+CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_FHANDLE=y
-- 
2.3.0-rc1
