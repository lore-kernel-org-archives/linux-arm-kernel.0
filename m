From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Jan 2013 15:24:00 +0900
Subject: [PATCH] ARM: mach-shmobile: armadillo: update defconfig
Message-ID: <1357712640-3065-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enable ARM_APPENDED_DTB

  Typically the bootloader of an armadillo board does not support DT
  so this option is useful.

* Do not disable CONFIG_SUSPEND

  Suspend seems to work fine on the armadillo

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/armadillo800eva_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 2e1a825..c29cf04 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -34,12 +34,12 @@ CONFIG_AEABI=y
 CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096 rw"
 CONFIG_CMDLINE_FORCE=y
 CONFIG_KEXEC=y
 CONFIG_VFP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-# CONFIG_SUSPEND is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
1.7.10.4
