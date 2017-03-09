From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu,  9 Mar 2017 10:51:19 -0800
Subject: [PATCH 2/3] ARM: brcmstb: Enable ARCH_HAS_HOLES_MEMORYMODEL
In-Reply-To: <20170309185120.1713-1-f.fainelli@gmail.com>
References: <20170309185120.1713-1-f.fainelli@gmail.com>
Message-ID: <20170309185120.1713-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Danesh Petigara <danesh.petigara@broadcom.com>

Due to the brcmstb SoC's memory map, we may have holes in the memory if
we don't populate the maximum amount of memory supported by e.g: the
first memory controller which spans either the first 1GiB or first 2GiB
of memory.

We need to select ARCH_HAS_HOLES_MEMORYMODEL in order to enable
CONFIG_HAVE_ARCH_PFN_VALID on platforms that have CONFIG_SPARSEMEM
enabled.

Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
[florian: Detailed commit message]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 403db76e3497..f9389c5910e7 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -198,6 +198,7 @@ config ARCH_BRCMSTB
 	select HAVE_ARM_ARCH_TIMER
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
+	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select ZONE_DMA if ARM_LPAE
 	select SOC_BRCMSTB
-- 
2.9.3
