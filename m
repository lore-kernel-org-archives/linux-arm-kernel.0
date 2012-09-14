From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 23:34:44 +0200
Subject: [PATCH 16/24] ARM: spear13xx: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-1-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
Message-ID: <1347658492-11608-17-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM is moving to stricter checks on readl/write functions,
so we need to use the correct types everywhere.

Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: spear-devel at list.st.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear13xx/include/mach/spear.h |   14 +++++++-------
 arch/arm/mach-spear13xx/spear13xx.c          |    6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h b/arch/arm/mach-spear13xx/include/mach/spear.h
index 65f27de..07d90ac 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear.h
@@ -17,26 +17,26 @@
 #include <asm/memory.h>
 
 #define PERIP_GRP2_BASE				UL(0xB3000000)
-#define VA_PERIP_GRP2_BASE			UL(0xFE000000)
+#define VA_PERIP_GRP2_BASE			IOMEM(0xFE000000)
 #define MCIF_SDHCI_BASE				UL(0xB3000000)
 #define SYSRAM0_BASE				UL(0xB3800000)
-#define VA_SYSRAM0_BASE				UL(0xFE800000)
+#define VA_SYSRAM0_BASE				IOMEM(0xFE800000)
 #define SYS_LOCATION				(VA_SYSRAM0_BASE + 0x600)
 
 #define PERIP_GRP1_BASE				UL(0xE0000000)
-#define VA_PERIP_GRP1_BASE			UL(0xFD000000)
+#define VA_PERIP_GRP1_BASE			IOMEM(0xFD000000)
 #define UART_BASE				UL(0xE0000000)
-#define VA_UART_BASE				UL(0xFD000000)
+#define VA_UART_BASE				IOMEM(0xFD000000)
 #define SSP_BASE				UL(0xE0100000)
 #define MISC_BASE				UL(0xE0700000)
-#define VA_MISC_BASE				IOMEM(UL(0xFD700000))
+#define VA_MISC_BASE				IOMEM(0xFD700000)
 
 #define A9SM_AND_MPMC_BASE			UL(0xEC000000)
-#define VA_A9SM_AND_MPMC_BASE			UL(0xFC000000)
+#define VA_A9SM_AND_MPMC_BASE			IOMEM(0xFC000000)
 
 /* A9SM peripheral offsets */
 #define A9SM_PERIP_BASE				UL(0xEC800000)
-#define VA_A9SM_PERIP_BASE			UL(0xFC800000)
+#define VA_A9SM_PERIP_BASE			IOMEM(0xFC800000)
 #define VA_SCU_BASE				(VA_A9SM_PERIP_BASE + 0x00)
 
 #define L2CC_BASE				UL(0xED000000)
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index cf936b1..e106488 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -114,17 +114,17 @@ void __init spear13xx_l2x0_init(void)
  */
 struct map_desc spear13xx_io_desc[] __initdata = {
 	{
-		.virtual	= VA_PERIP_GRP2_BASE,
+		.virtual	= (unsigned long)VA_PERIP_GRP2_BASE,
 		.pfn		= __phys_to_pfn(PERIP_GRP2_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= VA_PERIP_GRP1_BASE,
+		.virtual	= (unsigned long)VA_PERIP_GRP1_BASE,
 		.pfn		= __phys_to_pfn(PERIP_GRP1_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= VA_A9SM_AND_MPMC_BASE,
+		.virtual	= (unsigned long)VA_A9SM_AND_MPMC_BASE,
 		.pfn		= __phys_to_pfn(A9SM_AND_MPMC_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
-- 
1.7.10
