From: horms@verge.net.au (Simon Horman)
Date: Wed,  5 Sep 2012 10:34:53 +0900
Subject: [PATCH 3/3] ARM: shmobile: armadillo800eva: enable rw rootfs mount
In-Reply-To: <1346808893-14124-1-git-send-email-horms@verge.net.au>
References: <1346808893-14124-1-git-send-email-horms@verge.net.au>
Message-ID: <1346808893-14124-4-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

armadillo800eva default boot loader is "hermit",
and it's tag->u.core.flags has flag when kernel boots.
Because of this, ${LINUX}/arch/arm/kernel/setup.c :: parse_tag_core()
didn't remove MS_RDONLY flag from root_mountflags.
Thus, the rootfs is mounted as "readonly".
This patch adds "rw" kernel parameter,
and enable read/write mounts for rootfs

Cc: Masahiro Nakai <nakai@atmark-techno.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/armadillo800eva_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 7d87184..90610c7 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -33,7 +33,7 @@ CONFIG_AEABI=y
 CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096"
+CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096 rw"
 CONFIG_CMDLINE_FORCE=y
 CONFIG_KEXEC=y
 CONFIG_VFP=y
-- 
1.7.10.4
