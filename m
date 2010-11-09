From: dushistov@mail.ru (Evgeniy Dushistov)
Date: Tue, 9 Nov 2010 22:46:18 +0300
Subject: [PATCH] mv78xx: wrong cpu1 window base register address
Message-ID: <20101109194617.GA14544@maclin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The constant DDR_WINDOW_CPU1_BASE has wrong value.
Because of that mv78xx0_mbus_dram_info is not filled properly on
start, and in its turn drivers, that used mv78xx0_mbus_dram_info,
in my case mv643xx_eth.c, not work on second core.
According to

MV76100, MV78100, and MV78200 DiscoveryTM Innovation Series
CPU Family
Functional Specifications

address should be 0x1570.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>
---
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
index 788bdac..3eff399 100644
--- a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
@@ -65,7 +65,7 @@
  */
 #define DDR_VIRT_BASE		(MV78XX0_REGS_VIRT_BASE | 0x00000)
 #define  DDR_WINDOW_CPU0_BASE	(DDR_VIRT_BASE | 0x1500)
-#define  DDR_WINDOW_CPU1_BASE	(DDR_VIRT_BASE | 0x1700)
+#define  DDR_WINDOW_CPU1_BASE	(DDR_VIRT_BASE | 0x1570)
 
 #define DEV_BUS_PHYS_BASE	(MV78XX0_REGS_PHYS_BASE | 0x10000)
 #define DEV_BUS_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE | 0x10000)
-- 
1.7.2.2

-- 
/Evgeniy
