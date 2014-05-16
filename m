From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:43 +0900
Subject: [PATCH 2/9] ARM: shmobile: Use r8a7740 DT CPU Frequency in common case
In-Reply-To: <cover.1400200838.git.horms+renesas@verge.net.au>
References: <cover.1400200838.git.horms+renesas@verge.net.au>
Message-ID: <a0c1fb0c285d9aa5f9d078449cfa37883a3f5a91.1400200838.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert the common C-code-less r8a7740 DT board support
to use shmobile_init_delay() to be able to migrate away
from per-SoC delay setup functions.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Tested-by: Geert Uytterhoeven <geert@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 8f3c681..d1ce3ca 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -935,7 +935,7 @@ static const char *r8a7740_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.map_io		= r8a7740_map_io,
-	.init_early	= r8a7740_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= r8a7740_generic_init,
 	.dt_compat	= r8a7740_boards_compat_dt,
-- 
1.8.5.2
