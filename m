From: tony@atomide.com (Tony Lindgren)
Date: Thu,  1 Mar 2018 14:17:01 -0800
Subject: [PATCH 07/10] ARM: omap2plus_defconfig: Enable am335x and am437x PM
 options
In-Reply-To: <20180301221704.104530-1-tony@atomide.com>
References: <20180301221704.104530-1-tony@atomide.com>
Message-ID: <20180301221704.104530-8-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are needed to enable low-power suspend mode as described
by Dave.

Note that these depend on the am335x-pm-firmware.elf.

Cc: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -469,9 +469,16 @@ CONFIG_DMADEVICES=y
 CONFIG_DMA_OMAP=y
 CONFIG_TI_EDMA=y
 CONFIG_OMAP_IOMMU=y
+CONFIG_REMOTEPROC=m
+CONFIG_OMAP_REMOTEPROC=m
+CONFIG_WKUP_M3_RPROC=m
+CONFIG_SOC_TI=y
+CONFIG_AMX3_PM=m
+CONFIG_WKUP_M3_IPC=m
 CONFIG_EXTCON_PALMAS=m
 CONFIG_EXTCON_USB_GPIO=m
 CONFIG_TI_EMIF=m
+CONFIG_TI_EMIF_SRAM=m
 CONFIG_IIO=m
 CONFIG_IIO_SW_DEVICE=m
 CONFIG_IIO_SW_TRIGGER=m
-- 
2.16.2
