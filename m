From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Nov 2012 01:53:12 +0100
Subject: [PATCH 6/6] ARM: integrator: delete static UART1 mapping
Message-ID: <1352681592-13036-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrators does not use the UART1 for any debugging
or similar, dynamic mapping should be all that is needed
so delete this static map.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_ap.c | 5 -----
 arch/arm/mach-integrator/integrator_cp.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index becba43..771cbe4 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -121,11 +121,6 @@ static struct map_desc ap_io_desc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= IO_ADDRESS(INTEGRATOR_UART1_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_UART1_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	= IO_ADDRESS(INTEGRATOR_DBG_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_DBG_BASE),
 		.length		= SZ_4K,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index fc2b1e4..c4b6af9 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -105,11 +105,6 @@ static struct map_desc intcp_io_desc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= IO_ADDRESS(INTEGRATOR_UART1_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_UART1_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	= IO_ADDRESS(INTEGRATOR_DBG_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_DBG_BASE),
 		.length		= SZ_4K,
-- 
1.7.11.7
