From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 10 Jan 2013 10:23:55 +0900
Subject: [PATCH 1/5] ARM: mach-shmobile: mackerel: update defconfig
In-Reply-To: <1357781039-14003-1-git-send-email-horms+renesas@verge.net.au>
References: <1357781039-14003-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1357781039-14003-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enable ARM_APPENDED_DTB

  Typically the bootloader of a mackerel board does not support DT
  so this option is useful

* Add "rw" to command line

  This appears to be necessary for a successful NFS-root boot

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/mackerel_defconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index 2098ce1..8519721 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -23,7 +23,8 @@ CONFIG_AEABI=y
 CONFIG_FORCE_MAX_ZONEORDER=15
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=tty0, console=ttySC0,115200 earlyprintk=sh-sci.0,115200 root=/dev/nfs nfsroot=,tcp,v3 ip=dhcp memchunk.vpu=64m memchunk.veu0=8m memchunk.spu0=2m mem=240m"
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_CMDLINE="console=tty0, console=ttySC0,115200 earlyprintk=sh-sci.0,115200 root=/dev/nfs nfsroot=,tcp,v3 ip=dhcp memchunk.vpu=64m memchunk.veu0=8m memchunk.spu0=2m mem=240m rw"
 CONFIG_KEXEC=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM=y
-- 
1.7.10.4
