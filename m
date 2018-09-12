From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 12 Sep 2018 18:11:21 +0200
Subject: [PATCH v6 6/7] ARM: configs: at91: use new TCB timer driver
In-Reply-To: <20180912161122.7717-1-alexandre.belloni@bootlin.com>
References: <20180912161122.7717-1-alexandre.belloni@bootlin.com>
Message-ID: <20180912161122.7717-7-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unselecting ATMEL_TCLIB switches the TCB timer driver from tcb_clksrc to
timer-atmel-tcb.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 -
 arch/arm/configs/sama5_defconfig   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index e4b1be66b3f5..09f262e59fef 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -64,7 +64,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_ATMEL_TCLIB=y
 CONFIG_ATMEL_SSC=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 2080025556b5..f2bbc6339ca6 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -75,7 +75,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_ATMEL_TCLIB=y
 CONFIG_ATMEL_SSC=y
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
-- 
2.19.0.rc2
