From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 18:08:33 +0900
Subject: [PATCH 03/16] ARM: shmobile: bockw: Do not set command line in
 defconfig
In-Reply-To: <cover.1385629477.git.horms+renesas@verge.net.au>
References: <cover.1385629477.git.horms+renesas@verge.net.au>
Message-ID: <851f0cda469fdba6371ab2e268462aeb8393f08e.1385629477.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a set towards moving shmobile towards multi-platform
the kernel command line should be set in the DTB rather than
in the kernel config.

bockw already has the command line present in its DTS file
but it was being overrirden by the kernel config.

A side effect of this change is that "rw" is now present
on the command line which allows a boot using nfs root to
succeed in the case where userspace expects to be able
to write to the root filesystem.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/bockw_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 6583683..b35301f 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -27,8 +27,6 @@ CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
-CONFIG_CMDLINE="console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp"
-CONFIG_CMDLINE_FORCE=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_SUSPEND is not set
 CONFIG_PM_RUNTIME=y
-- 
1.8.4
