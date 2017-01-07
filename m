From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Sat,  7 Jan 2017 22:52:28 +0530
Subject: [PATCH WIP 4/4] ARM: remove compile time vector base for CP15 case
In-Reply-To: <20170107171339.GA5044@afzalpc>
References: <20170107171339.GA5044@afzalpc>
Message-ID: <20170107172228.6451-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vectors base is now dynamically updated for Hivecs as well as for
REMAP_VECTORS_TO_RAM case to DRAM_START. Hence remove these CP15
cases.

TODO:
Kill off VECTORS_BASE completely - this would require to handle MMU
 case as well as ARM_MPU scenario dynamically.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bc6f4065840e..720ee62b4955 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -232,8 +232,7 @@ config ARCH_MTD_XIP
 
 config VECTORS_BASE
 	hex
-	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
-	default DRAM_BASE if REMAP_VECTORS_TO_RAM
+	default 0xffff0000 if MMU
 	default 0x00000000
 	help
 	  The base address of exception vectors.  This must be two pages
-- 
2.11.0
