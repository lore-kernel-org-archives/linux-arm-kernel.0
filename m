From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:32 -0500
Subject: [PATCH 14/23] ARM: realview: fix map_desc alignment
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-15-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

REALVIEW_PBX_TILE_GIC_CPU_BASE is not 4KB aligned which causes an
overlapping mapping. Use REALVIEW_PBX_TILE_SCU_BASE instead which is
aligned.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-realview/realview_pbx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 63c4114afa..a15f5d6edb 100644
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
1.7.7.1.431.g10b2a
