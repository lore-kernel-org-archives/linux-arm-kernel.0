From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 25 Nov 2015 13:13:35 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable NFSv4 client
Message-ID: <1448424815-30192-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NFS client is already enabled (NFS_FS) and by default it enables clients
for version 2 and 3. Enable explicitly the version 4 client to utilize
the newer protocol.

The NFS client is especially useful for testing kernel in automated
environments (network boot with network file system).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index b3f9c7558851..409adc1eaf33 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -224,6 +224,7 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
-- 
1.9.1
