From: robherring2@gmail.com (Rob Herring)
Date: Mon,  5 Aug 2013 17:50:06 -0500
Subject: [PATCH 2/5] ARM: make dma_addr_t 64-bit on LPAE
In-Reply-To: <1375743009-28972-1-git-send-email-robherring2@gmail.com>
References: <1375743009-28972-1-git-send-email-robherring2@gmail.com>
Message-ID: <1375743009-28972-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

LPAE systems may have 64-bit capable DMA, so dma_addr_t needs to be
64-bit.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 6cacdc8..9f6f3d7 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -625,7 +625,7 @@ config ARCH_PHYS_ADDR_T_64BIT
 	def_bool ARM_LPAE
 
 config ARCH_DMA_ADDR_T_64BIT
-	bool
+	def_bool ARM_LPAE
 
 config ARM_THUMB
 	bool "Support Thumb user binaries" if !CPU_THUMBONLY
-- 
1.8.1.2
