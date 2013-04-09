From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  9 Apr 2013 17:26:21 -0300
Subject: [PATCH v6 5/5] ARM: mvebu: Add Device Bus and CFI flash memory
 support to defconfig
In-Reply-To: <1365539181-29242-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1365539181-29242-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1365539181-29242-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch selects the devbus driver as part of the mvebu default
config, along with the required options to detect and support
CFI flash memories.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/mvebu_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 2ec8119..fe8ba26 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -46,6 +46,11 @@ CONFIG_I2C_MV64XXX=y
 CONFIG_MTD=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_M25P80=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
@@ -65,6 +70,8 @@ CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
+CONFIG_MEMORY=y
+CONFIG_MVEBU_DEVBUS=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
1.8.1.5
