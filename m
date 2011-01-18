From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 18 Jan 2011 12:41:55 +0530
Subject: [PATCH V4 28/62] ST SPEAr: Changing resource size of amba devices to
	SZ_4K
In-Reply-To: <cover.1295333957.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
Message-ID: <b1450a183c70640562e411ad4ab54a52f51374ec.1295333958.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear3xx/spear300.c |    2 +-
 arch/arm/mach-spear3xx/spear320.c |    2 +-
 arch/arm/mach-spear3xx/spear3xx.c |    2 +-
 arch/arm/mach-spear6xx/spear6xx.c |    8 +++-----
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index fceb71f..6989407 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -382,7 +382,7 @@ struct amba_device clcd_device = {
 	},
 	.res = {
 		.start = SPEAR300_CLCD_BASE,
-		.end = SPEAR300_CLCD_BASE + SPEAR300_CLCD_SIZE - 1,
+		.end = SPEAR300_CLCD_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.dma_mask = ~0,
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 6ab35db..ab4ad8e 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -399,7 +399,7 @@ struct amba_device clcd_device = {
 	},
 	.res = {
 		.start = SPEAR320_CLCD_BASE,
-		.end = SPEAR320_CLCD_BASE + SPEAR320_CLCD_SIZE - 1,
+		.end = SPEAR320_CLCD_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.dma_mask = ~0,
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index d8efad2..61db0b2f 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -79,7 +79,7 @@ struct amba_device uart_device = {
 	},
 	.res = {
 		.start = SPEAR3XX_ICM1_UART_BASE,
-		.end = SPEAR3XX_ICM1_UART_BASE + SPEAR3XX_ICM1_UART_SIZE - 1,
+		.end = SPEAR3XX_ICM1_UART_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.irq = {IRQ_UART, NO_IRQ},
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 58f1a15..d00b581 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -35,7 +35,7 @@ struct amba_device clcd_device = {
 	},
 	.res = {
 		.start = SPEAR6XX_ICM3_CLCD_BASE,
-		.end = SPEAR6XX_ICM3_CLCD_BASE + SPEAR6XX_ICM3_CLCD_SIZE - 1,
+		.end = SPEAR6XX_ICM3_CLCD_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.dma_mask = ~0,
@@ -117,8 +117,7 @@ struct amba_device uart_device[] = {
 		},
 		.res = {
 			.start = SPEAR6XX_ICM1_UART0_BASE,
-			.end = SPEAR6XX_ICM1_UART0_BASE +
-				SPEAR6XX_ICM1_UART0_SIZE - 1,
+			.end = SPEAR6XX_ICM1_UART0_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
 		.irq = {IRQ_UART_0, NO_IRQ},
@@ -128,8 +127,7 @@ struct amba_device uart_device[] = {
 		},
 		.res = {
 			.start = SPEAR6XX_ICM1_UART1_BASE,
-			.end = SPEAR6XX_ICM1_UART1_BASE +
-				SPEAR6XX_ICM1_UART1_SIZE - 1,
+			.end = SPEAR6XX_ICM1_UART1_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
 		.irq = {IRQ_UART_1, NO_IRQ},
-- 
1.7.2.2
