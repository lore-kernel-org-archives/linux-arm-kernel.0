From: s-anna@ti.com (Suman Anna)
Date: Thu, 1 Sep 2016 17:58:46 -0500
Subject: [PATCH 5/5] ARM: configs: keystone: Enable Generic on-chip SRAM driver
In-Reply-To: <20160901225846.31058-1-s-anna@ti.com>
References: <20160901225846.31058-1-s-anna@ti.com>
Message-ID: <20160901225846.31058-6-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the Keystone 2 SoCs have an on-chip RAM called the MultiCore
Shared Memory (MSM) RAM managed by the Multicore Shared Memory
Controller (MSMC) that provides faster access compared to normal
DDR.

This patch enables the Generic on-chip SRAM driver that manages
this memory in software.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/configs/keystone_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 71b42e66488a..28afcf7733f2 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -126,6 +126,7 @@ CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_SRAM=y
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-- 
2.9.3
