From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Mon, 26 Mar 2018 14:50:00 -0500
Subject: [PATCH] ARM: socfpga_defconfig: Remove QSPI Sector 4K size force
Message-ID: <1522093800-7822-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Remove QSPI Sector 4K size force which is causing QSPI boot
problems with the JFFS2 root filesystem.

Fixes the following error:
     "Magic bitmask 0x1985 not found at ..."

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm/configs/socfpga_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 2620ce790db0..371fca4e1ab7 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -57,6 +57,7 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_SPI_NOR=y
+# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
 CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_OF_OVERLAY=y
 CONFIG_OF_CONFIGFS=y
-- 
2.7.4
