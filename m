From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:31 -0500
Subject: [PATCH 13/23] ARM: versatile: remove overlapping map_desc entry
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-14-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The map_desc for VERSATILE_GPIO0_BASE overlaps with VERSATILE_SCTL_BASE.
The overlapping entry can be removed.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-versatile/core.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e340a54251..4d8dfc15f3 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -141,11 +141,6 @@ static struct map_desc versatile_io_desc[] __initdata = {
 	},
 #ifdef CONFIG_MACH_VERSATILE_AB
  	{
-		.virtual	=  IO_ADDRESS(VERSATILE_GPIO0_BASE),
-		.pfn		= __phys_to_pfn(VERSATILE_GPIO0_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	=  IO_ADDRESS(VERSATILE_IB2_BASE),
 		.pfn		= __phys_to_pfn(VERSATILE_IB2_BASE),
 		.length		= SZ_64M,
-- 
1.7.7.1.431.g10b2a
