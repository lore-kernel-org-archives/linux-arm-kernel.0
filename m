From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 19 Oct 2015 16:18:35 +0530
Subject: [RFC PATCH] ARM: exynos_defconfig: Increase CONFIG_BLK_DEV_RAM_SIZE to
 64K
Message-ID: <1445251715-9725-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_BLK_DEV_RAM_SIZE is currently set to 8K, which is a bit on the
smaller side, lets bump it up to 64K so that a bigger RAM_DISK can
be used with defconfig.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
Every time I build exynos_defconfig, I need to manually change RAM_SIZE
to match my ramdisk image size. I am not sure what is the best ramdisk size
might be, but bumping it to 64K might be a reasonable one.

 arch/arm/configs/exynos_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 3349713e6c63..e692aaa2cb8c 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
-- 
1.7.10.4
