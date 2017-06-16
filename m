From: butao@hisilicon.com (Bu Tao)
Date: Fri, 16 Jun 2017 14:51:19 +0800
Subject: [PATCH v2 5/5] arm64: defconfig: enable f2fs and squashfs
In-Reply-To: <20170616065119.10704-1-butao@hisilicon.com>
References: <20170616065119.10704-1-butao@hisilicon.com>
Message-ID: <20170616065119.10704-6-butao@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Partitions in HiKey960 are formatted as f2fs and squashfs.
f2fs is for userdata; squashfs is for system. Both partitions are required
by Android.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Chen Jun <chenjun14@huawei.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 379c942fe114..d73351fa0c9a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -494,6 +494,7 @@ CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_ACPI=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
+CONFIG_F2FS_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
@@ -509,6 +510,13 @@ CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_EFIVAR_FS=y
 CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_FILE_DIRECT=y
+CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
+CONFIG_SQUASHFS_XATTR=y
+CONFIG_SQUASHFS_LZ4=y
+CONFIG_SQUASHFS_LZO=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_NFS_V4_1=y
-- 
2.11.GIT
