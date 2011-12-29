From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Thu, 29 Dec 2011 11:38:29 +0100
Subject: [PATCH V2] Enable 32 bit flash support for iMX21ADS board
Message-ID: <1325155109-17738-1-git-send-email-jaccon.bastiaansen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel configuration for the i.MX21ADS board (imx_v4_v5_defconfig)
doesn't enable 32 bit flash support. But the i.MX21ADS specific code
adds a 32 bit flash device, resulting in a kernel that refuses to
boot.


Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
---
 arch/arm/configs/imx_v4_v5_defconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 11a4192..fccb470 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -67,7 +67,6 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
 CONFIG_MTD_CFI_GEOMETRY=y
 # CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
-# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
 # CONFIG_MTD_CFI_I2 is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
-- 
1.7.1
