From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 30 Jan 2017 21:27:49 +0200
Subject: [PATCH] ARM: exynos_defconfig: Enable DYNAMIC_DEBUG and get rid of
 old ext3
Message-ID: <20170130192749.3690-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DYNAMIC_DEBUG is quite useful for debugging kernels and should not cause
noticeable performance regressions.  It makes the kernel noticeably
bigger (around 4%) but this difference should not impact typical
developer and reference usage of this defconfig.

Sizes:
zImage-old:       4641496 bytes
zImage-new:       4811384 bytes

   text	   data	    bss	    dec	    hex	filename
7031229	2570916	 327016	9929161	 9781c9	vmlinux-old
7205921	2800052	 327016	10332989 9dab3d	vmlinux-new

Additionally, remove the EXT3_FS symbol because it is entirely replaced
by EXT4_FS.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/exynos_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 12b8f69cbb52..746739027da6 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -240,7 +240,7 @@ CONFIG_PWM=y
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PHY_EXYNOS5250_SATA=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
@@ -255,6 +255,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-- 
2.9.3
