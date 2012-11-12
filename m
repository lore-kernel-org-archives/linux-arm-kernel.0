From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Nov 2012 01:53:06 +0100
Subject: [PATCH 5/6] ARM: integrator: delete SC mapping on the CP
Message-ID: <1352681586-13004-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrator/CP does not use the address space defined as
used by the Integrator/AP system controller, it's just unused
memory. So just delete this static mapping from the CP static
mapping table.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_cp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 7220210..fc2b1e4 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -85,11 +85,6 @@ static struct map_desc intcp_io_desc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= IO_ADDRESS(INTEGRATOR_SC_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_SC_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	= IO_ADDRESS(INTEGRATOR_EBI_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_EBI_BASE),
 		.length		= SZ_4K,
-- 
1.7.11.7
