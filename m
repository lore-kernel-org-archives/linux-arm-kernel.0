From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 13:42:59 +0900
Subject: [PATCH 2/4] ARM: shmobile: r8a7779: Use DT CPU Frequency in common
 case
In-Reply-To: <1400215381-7027-1-git-send-email-horms+renesas@verge.net.au>
References: <1400215381-7027-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400215381-7027-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the common C-code-less r8a7779 DT board support
to use shmobile_init_delay() to be able to migrate away
from per-SoC delay setup functions.

Based on work by Magnus dam for the r8a7740 SoC.

Cc: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index c0e61d5..3cad080 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -773,7 +773,7 @@ static const char *r8a7779_compat_dt[] __initdata = {
 
 DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
 	.map_io		= r8a7779_map_io,
-	.init_early	= r8a7779_init_delay,
+	.init_early	= shmobile_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= r8a7779_add_standard_devices_dt,
-- 
1.8.5.2
