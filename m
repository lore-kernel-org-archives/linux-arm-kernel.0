From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 May 2014 08:32:38 +0900
Subject: [PATCH 02/04] ARM: shmobile: Use r8a7740 DT CPU Frequency in common
 case
In-Reply-To: <20140507233219.29712.9253.sendpatchset@w520>
References: <20140507233219.29712.9253.sendpatchset@w520>
Message-ID: <20140507233238.29712.19087.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert the common C-code-less r8a7740 DT board support
to use shmobile_init_delay() to be able to migrate away
from per-SoC delay setup functions.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7740.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2014-04-24 17:53:29.000000000 +0900
@@ -924,7 +924,7 @@ static const char *r8a7740_boards_compat
 
 DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.map_io		= r8a7740_map_io,
-	.init_early	= r8a7740_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= r8a7740_generic_init,
 	.dt_compat	= r8a7740_boards_compat_dt,
