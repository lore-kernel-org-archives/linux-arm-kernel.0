From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Thu, 29 Dec 2011 00:14:26 +0100
Subject: [PATCH] Enable 32 bit flash support for iMX21ADS board
Message-ID: <1325114066-26596-1-git-send-email-jaccon.bastiaansen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel configuration for the i.MX21ADS board (imx_v4_v5_defconfig)
doesn't enable 32 bit flash support. But the i.MX21ADS specific code
adds a 32 bit flash device, resulting in a kernel that refuses to
boot.

Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
---
 arch/arm/configs/imx_v4_v5_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 11a4192..ae2c106 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -66,8 +66,8 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
 CONFIG_MTD_CFI_GEOMETRY=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
 # CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
-# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
 # CONFIG_MTD_CFI_I2 is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
-- 
1.7.1
