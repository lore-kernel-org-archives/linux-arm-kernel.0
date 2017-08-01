From: vigneshr@ti.com (Vignesh R)
Date: Tue, 1 Aug 2017 10:24:34 +0530
Subject: [PATCH 7/7] ARM: configs: keystone: Enable Cadence QSPI driver
In-Reply-To: <20170801045434.8733-1-vigneshr@ti.com>
References: <20170801045434.8733-1-vigneshr@ti.com>
Message-ID: <20170801045434.8733-8-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

66AK2G SoC has a Cadence QSPI IP. Therefore, enable cadence-quadspi
driver as part of keystone_defconfig. Since, QSPI flash can be used to
for root filesystem, built it into the kernel instead of module.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/configs/keystone_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index d47ea43d097e..4c8abf3c1ab1 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -124,6 +124,7 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_SPI_NOR=y
+CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_SRAM=y
-- 
2.13.3
