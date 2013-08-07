From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:24:18 +0900
Subject: [GIT PULL 1/4] ARM: shmobile: marzen: Enable ARM_APPENDED_DTB in
 defconfig
In-Reply-To: <cover.1375842392.git.horms+renesas@verge.net.au>
References: <cover.1375842392.git.horms+renesas@verge.net.au>
Message-ID: <8c167a825d56e9946bb54d91017a53efb04ffdaf.1375842392.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"ARM: shmobile: marzen: Switch to DT_MACHINE_START" moves marzen
over to use DT_MACHINE_START, however, the prevalent boot loader
does not support booting with a separate dtb. Thus, it makes
sense to use ARM_APPENDED_DTB by default.

This is consistent with other shmobile defconfigs.

Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 494e70a..82e4040 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -29,6 +29,7 @@ CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CMDLINE="console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on"
 CONFIG_CMDLINE_FORCE=y
 CONFIG_KEXEC=y
-- 
1.8.3.2
