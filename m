From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 30 Apr 2014 23:26:40 -0700
Subject: [PATCH v2 05/12] ARM: lpc32xx: add MTD_SPI_NOR (new dependency for
 M25P80)
In-Reply-To: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
References: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1398925607-7482-6-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defconfig contains the CONFIG_M25P80 symbol, which is now
dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to satisfy
the new dependency.

At the same time, drop the now-nonexistent CONFIG_MTD_CHAR symbol.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Roland Stigge <stigge@antcom.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/configs/lpc32xx_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 398a367ffce8..2de54c35fb47 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -53,12 +53,12 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_SLC_LPC32XX=y
 CONFIG_MTD_NAND_MLC_LPC32XX=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
-- 
1.8.3.2
