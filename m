From: net147@gmail.com (Jonathan Liu)
Date: Mon, 21 Sep 2015 16:13:22 +1000
Subject: [PATCH] ARM: sunxi_defconfig: enable MODULE_UNLOAD
Message-ID: <1442816002-7821-1-git-send-email-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Loadable module support is enabled so we should allow unloading
modules too. This also allows lsmod to show values other than "-2" in
the "Used by" column.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 51eea22..517df2e 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -5,6 +5,7 @@ CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PERF_EVENTS=y
 CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
-- 
2.5.0
