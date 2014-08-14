From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 15 Aug 2014 08:03:25 +0900
Subject: [PATCH] ARM: shmobile: defconfig: enable
 ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
Message-ID: <1408057405-10568-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"ARM: shmobile: defconfig: enable initrd and atag dtb compat" enables
CONFIG_ARM_ATAG_DTB_COMPAT, however, empirically
ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is also required for my kzm9d board to
boot.

Cc: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

Without this change I do not see any kernel console output at all.
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index f847a9f..e343dc8 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -35,6 +35,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y
 CONFIG_KEXEC=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
2.0.1
