From: s-anna@ti.com (Suman Anna)
Date: Fri, 6 Jan 2017 15:57:29 -0600
Subject: [PATCH v2 5/9] ARM: configs: keystone: Enable Generic on-chip SRAM
 driver
In-Reply-To: <20170106215733.41637-1-s-anna@ti.com>
References: <20170106215733.41637-1-s-anna@ti.com>
Message-ID: <20170106215733.41637-6-s-anna@ti.com>
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
v2: No changes

 arch/arm/configs/keystone_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 78cd2f197e01..1331f6dc456a 100644
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
2.10.2
