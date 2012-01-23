From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 23 Jan 2012 14:16:17 -0200
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Fix the selection of 32 bit flash
 support for iMX21ADS board
Message-ID: <1327335377-30420-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 1a96571d (Enable 32 bit flash support for iMX21ADS board) aimed to 
enable 32 bit flash support, but all it did was to delete an unset option.

Fix this by enabling CONFIG_MTD_MAP_BANK_WIDTH_4 option.

Cc: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Jaccon,

I don't have a MX21ADS board handy to test it, but I guess this was the correct
intention of your patch, right?

 arch/arm/configs/imx_v4_v5_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index a22e930..dac71c1 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -68,6 +68,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
 CONFIG_MTD_CFI_GEOMETRY=y
 # CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
 # CONFIG_MTD_CFI_I2 is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
-- 
1.7.1
