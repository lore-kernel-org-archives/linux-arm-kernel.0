From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  9 Nov 2016 08:15:37 -0600
Subject: [PATCHv2] ARM: socfpga_defconfig: enable FS configs to support
 Angstrom filesystem
Message-ID: <20161109141537.4255-1-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

systemd on the Angstrom root file system expects AUTOFS to be configured
as a module and NFSD to be statically linked into the kernel. This patch
adds the necessary configuration to get rid two "FAILED" error messages
during systemd startup.

Signed-off-by: Matthew Gerlach <mgerlach@opensource.altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: provide a more descriptive changelog
---
 arch/arm/configs/socfpga_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 18d3ec1..2e1d254 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -116,13 +116,18 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT3_FS=y
+CONFIG_AUTOFS4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_NTFS_RW=y
 CONFIG_TMPFS=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
+CONFIG_NFSD=y
+CONFIG_NFSD_V3_ACL=y
+CONFIG_NFSD_V4=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
-- 
2.8.3
