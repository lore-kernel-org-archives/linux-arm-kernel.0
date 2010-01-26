From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 09:20:22 +0000
Subject: [PATCH] ARM: S3C6400: Update s3c6400_defconfig for bigger initrds for
	SMDK6410
In-Reply-To: <1264497623-21340-1-git-send-email-ben-linux@fluff.org>
References: <1264497623-21340-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264497623-21340-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Samsung initrd for SMDK6410 is now bigger than the original initrds
that where used. Increase the command-line size and the size of the ramdisk
that it is unpacked into.

Also change the default init to /linuxrc to avoid problems with the current
SMDK ramdisk image failing to run /bin/bash.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/configs/s3c6400_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index f56e50f..c018435 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -256,7 +256,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0
 CONFIG_ZBOOT_ROM_BSS=0
-CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/bin/bash initrd=0x51000000,4M"
+CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/linuxrc initrd=0x51000000,6M ramdisk_size=6144"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 
-- 
1.6.0.4
