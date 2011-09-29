From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 Sep 2011 16:22:02 -0500
Subject: [PATCH] ARM: realview: fix map_desc alignment
In-Reply-To: <4E84E0CA.2050905@gmail.com>
References: <4E84E0CA.2050905@gmail.com>
Message-ID: <1317331322-4439-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

REALVIEW_PBX_TILE_GIC_CPU_BASE is not 4KB aligned which causes an
overlapping mapping. Use REALVIEW_PBX_TILE_SCU_BASE instead which is
aligned.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-realview/realview_pbx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 363b0ab..5930a33 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -98,8 +98,8 @@ static struct map_desc realview_pbx_io_desc[] __initdata = {
 
 static struct map_desc realview_local_io_desc[] __initdata = {
 	{
-		.virtual        = IO_ADDRESS(REALVIEW_PBX_TILE_GIC_CPU_BASE),
-		.pfn            = __phys_to_pfn(REALVIEW_PBX_TILE_GIC_CPU_BASE),
+		.virtual        = IO_ADDRESS(REALVIEW_PBX_TILE_SCU_BASE),
+		.pfn            = __phys_to_pfn(REALVIEW_PBX_TILE_SCU_BASE),
 		.length         = SZ_4K,
 		.type           = MT_DEVICE,
 	}, {
-- 
1.7.5.4
