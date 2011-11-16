From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:33 -0500
Subject: [PATCH 15/23] ARM: realview-eb11mp: fix map_desc alignment
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-16-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

REALVIEW_EB11MP_GIC_CPU_BASE is not 4KB aligned which causes an
overlapping mapping. Use REALVIEW_EB11MP_SCU_BASE instead which is
aligned.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-realview/realview_eb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 026c66ad7e..a9874e176f 100644
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
1.7.7.1.431.g10b2a
