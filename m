From: swarren@nvidia.com (Stephen Warren)
Date: Tue,  3 Jan 2012 15:25:18 -0700
Subject: [PATCH 2/4] ARM: tegra: uncompress.h: Store UART address in a variable
In-Reply-To: <1325629520-23018-1-git-send-email-swarren@nvidia.com>
References: <1325629520-23018-1-git-send-email-swarren@nvidia.com>
Message-ID: <1325629520-23018-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Anderson <dianders@chromium.org>

This will allow a future change to auto-detect which UART to use.

Signed-off-by: Doug Anderson <dianders@chromium.org>
[swarren: Extracted from a larger patch by Doug]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/uncompress.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
index 9797279..bb3fd35 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -30,10 +30,10 @@
 
 #define DEBUG_UART_SHIFT 2
 
+volatile u8 *uart;
+
 static void putc(int c)
 {
-	volatile u8 *uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
-
 	if (uart == NULL)
 		return;
 
@@ -50,8 +50,8 @@ static inline void arch_decomp_setup(void)
 {
 	volatile u32 *apb_misc = (volatile u32 *)TEGRA_APB_MISC_BASE;
 	u32 chip, div;
-	volatile u8 *uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
 
+	uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
 	if (uart == NULL)
 		return;
 
-- 
1.7.0.4
