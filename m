From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:09 -0700
Subject: [PATCH 18/34] DA830 EVM: use DA8XX_AEMIF_*_BASE #define's
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-19-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

The board file #define's its own version of EMIFA base addresses, while there
are DA8XX_AEMIF_*_BASE macros #define'd in <mach/da8xx.h>.  Start using them
instead.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 9257056..8f079d2 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -33,9 +33,6 @@
 #define DA830_EVM_PHY_MASK		0x0
 #define DA830_EVM_MDIO_FREQUENCY	2200000	/* PHY bus frequency */
 
-#define DA830_EMIF25_ASYNC_DATA_CE3_BASE	0x62000000
-#define DA830_EMIF25_CONTROL_BASE		0x68000000
-
 /*
  * USB1 VBUS is controlled by GPIO1[15], over-current is reported on GPIO2[4].
  */
@@ -375,13 +372,13 @@ static struct davinci_nand_pdata da830_evm_nand_pdata = {
 
 static struct resource da830_evm_nand_resources[] = {
 	[0] = {		/* First memory resource is NAND I/O window */
-		.start	= DA830_EMIF25_ASYNC_DATA_CE3_BASE,
-		.end	= DA830_EMIF25_ASYNC_DATA_CE3_BASE + PAGE_SIZE - 1,
+		.start	= DA8XX_AEMIF_CS3_BASE,
+		.end	= DA8XX_AEMIF_CS3_BASE + PAGE_SIZE - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {		/* Second memory resource is AEMIF control registers */
-		.start	= DA830_EMIF25_CONTROL_BASE,
-		.end	= DA830_EMIF25_CONTROL_BASE + SZ_32K - 1,
+		.start	= DA8XX_AEMIF_CTL_BASE,
+		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 };
-- 
1.7.0.2
