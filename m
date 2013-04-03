From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 03 Apr 2013 15:33:18 +0900
Subject: [PATCH 03/04] ARM: shmobile: sh7372 pinmux platform device cleanup
In-Reply-To: <20130403063246.2500.65318.sendpatchset@w520>
References: <20130403063246.2500.65318.sendpatchset@w520>
Message-ID: <20130403063318.2500.49100.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use DEFINE_RES_MEM() and platform_device_register_simple()
to save a couple of lines of code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh7372.c |   24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2013-04-03 15:17:30.000000000 +0900
@@ -62,29 +62,15 @@ void __init sh7372_map_io(void)
 }
 
 /* PFC */
-static struct resource sh7372_pfc_resources[] = {
-	[0] = {
-		.start	= 0xe6050000,
-		.end	= 0xe6057fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= 0xe605800c,
-		.end	= 0xe6058027,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device sh7372_pfc_device = {
-	.name		= "pfc-sh7372",
-	.id		= -1,
-	.resource	= sh7372_pfc_resources,
-	.num_resources	= ARRAY_SIZE(sh7372_pfc_resources),
+static const struct resource pfc_resources[] = {
+	DEFINE_RES_MEM(0xe6050000, 0x8000),
+	DEFINE_RES_MEM(0xe605800c, 0x001c),
 };
 
 void __init sh7372_pinmux_init(void)
 {
-	platform_device_register(&sh7372_pfc_device);
+	platform_device_register_simple("pfc-sh7372", -1, pfc_resources,
+					ARRAY_SIZE(pfc_resources));
 }
 
 /* SCIFA0 */
