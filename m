From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 11 Dec 2016 18:41:58 +0530
Subject: [PATCH 1/2] ARM: nommu: allow enabling REMAP_VECTORS_TO_RAM
In-Reply-To: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
References: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
Message-ID: <20161211131158.3120-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

REMAP_VECTORS_TO_RAM depends on DRAM_BASE, but since DRAM_BASE is a
hex, REMAP_VECTORS_TO_RAM could never get enabled. Also depending on
DRAM_BASE is redundant as whenever REMAP_VECTORS_TO_RAM makes itself
available to Kconfig, DRAM_BASE also is available as the Kconfig gets
sourced on !MMU.

Signed-off-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/Kconfig-nommu | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index aed66d5df7f1..b7576349528c 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -34,8 +34,7 @@ config PROCESSOR_ID
 	  used instead of the auto-probing which utilizes the register.
 
 config REMAP_VECTORS_TO_RAM
-	bool 'Install vectors to the beginning of RAM' if DRAM_BASE
-	depends on DRAM_BASE
+	bool 'Install vectors to the beginning of RAM'
 	help
 	  The kernel needs to change the hardware exception vectors.
 	  In nommu mode, the hardware exception vectors are normally
-- 
2.11.0
