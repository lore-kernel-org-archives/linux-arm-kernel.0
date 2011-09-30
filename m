From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 Sep 2011 19:46:18 -0500
Subject: [PATCH] ARM: realview-eb11mp: fix map_desc alignment
In-Reply-To: <4E84E0CA.2050905@gmail.com>
References: <4E84E0CA.2050905@gmail.com>
Message-ID: <1317343578-5307-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

REALVIEW_EB11MP_GIC_CPU_BASE is not 4KB aligned which causes an
overlapping mapping. Use REALVIEW_EB11MP_SCU_BASE instead which is
aligned.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
Nico,

Here's another one. I visually checked the remaining Realview platforms and
think they are fine.

Rob

 arch/arm/mach-realview/realview_eb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 026c66a..a9874e1 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -91,8 +91,8 @@ static struct map_desc realview_eb_io_desc[] __initdata = {
 
 static struct map_desc realview_eb11mp_io_desc[] __initdata = {
 	{
-		.virtual	= IO_ADDRESS(REALVIEW_EB11MP_GIC_CPU_BASE),
-		.pfn		= __phys_to_pfn(REALVIEW_EB11MP_GIC_CPU_BASE),
+		.virtual	= IO_ADDRESS(REALVIEW_EB11MP_SCU_BASE),
+		.pfn		= __phys_to_pfn(REALVIEW_EB11MP_SCU_BASE),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
-- 
1.7.5.4
