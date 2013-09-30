From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 30 Sep 2013 18:41:26 -0400
Subject: [PATCH v2 4/5] ARM: keystone: Select TI_EDMA to be able to enable SPI
 driver
In-Reply-To: <1380580887-24249-1-git-send-email-santosh.shilimkar@ti.com>
References: <1380580887-24249-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1380580887-24249-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select the TI EDMA to be able to enable SPI driver on Keystone
SOCs. Keystone SOCs share the EDMA IP with other TI SOCs.

Note that EDMA support hasn't been added and tested yet for
Keystone SOC data(device tree), but building it, is harmless since
driver like SPI already takes care of supporting non-dma mode
in the absence of such data.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index d7c425d..525e4b9 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -10,6 +10,8 @@ config ARCH_KEYSTONE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_ERRATA_798181 if SMP
 	select COMMON_CLK_KEYSTONE
+	select TI_EDMA
+	select TI_PRIV_EDMA
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
-- 
1.7.9.5
