From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:58:36 +0000
Subject: [PATCH 12/20] ARM: sa1111: delete unused physical GPIO register
 definitions
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPHI-00044R-Vy@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of the unused GPIO register definitions - we access GPIO
registers through the base + offset method, and having the phys
address definitions is unnecessary duplication.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardware/sa1111.h |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 74afe20..5ba2e13 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -327,22 +327,6 @@
  *    PC_SSR		GPIO Block C Sleep State
  */
 
-#define _PA_DDR		_SA1111( 0x1000 )
-#define _PA_DRR		_SA1111( 0x1004 )
-#define _PA_DWR		_SA1111( 0x1004 )
-#define _PA_SDR		_SA1111( 0x1008 )
-#define _PA_SSR		_SA1111( 0x100c )
-#define _PB_DDR		_SA1111( 0x1010 )
-#define _PB_DRR		_SA1111( 0x1014 )
-#define _PB_DWR		_SA1111( 0x1014 )
-#define _PB_SDR		_SA1111( 0x1018 )
-#define _PB_SSR		_SA1111( 0x101c )
-#define _PC_DDR		_SA1111( 0x1020 )
-#define _PC_DRR		_SA1111( 0x1024 )
-#define _PC_DWR		_SA1111( 0x1024 )
-#define _PC_SDR		_SA1111( 0x1028 )
-#define _PC_SSR		_SA1111( 0x102c )
-
 #define SA1111_GPIO	0x1000
 
 #define SA1111_GPIO_PADDR	(0x000)
-- 
1.7.4.4
