From: liwei213@huawei.com (Li Wei)
Date: Fri, 25 May 2018 17:17:12 +0800
Subject: [PATCH v10 5/5] arm64: defconfig: enable f2fs and squashfs
In-Reply-To: <20180525091712.37227-1-liwei213@huawei.com>
References: <20180525091712.37227-1-liwei213@huawei.com>
Message-ID: <20180525091712.37227-6-liwei213@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Partitions in HiKey960 are formatted as f2fs and squashfs.
f2fs is for userdata; squashfs is for system. Both partitions are required
by Android.

Signed-off-by: Li Wei <liwei213@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d42b1ecaf490..e8036cddb272 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -613,6 +613,7 @@ CONFIG_ACPI_APEI_MEMORY_FAILURE=y
 CONFIG_ACPI_APEI_EINJ=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
+CONFIG_F2FS_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
@@ -628,6 +629,13 @@ CONFIG_HUGETLBFS=y
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
2.15.0
