From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 01 Jul 2013 20:48:07 +0900
Subject: [PATCH] ARM: shmobile: emev2 GIO3 resource fix
Message-ID: <20130701114807.29137.43972.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Fix GIO3 base addresses for EMEV2.

This bug was introduced by 088efd9273b5076a0aead479aa31f1066d182b3e
("mach-shmobile: Emma Mobile EV2 GPIO support V3") which was included in v3.5.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- 0015/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-07-01 20:21:29.000000000 +0900
@@ -286,14 +286,14 @@ static struct gpio_em_config gio3_config
 static struct resource gio3_resources[] = {
 	[0] = {
 		.name	= "GIO_096",
-		.start	= 0xe0050100,
-		.end	= 0xe005012b,
+		.start	= 0xe0050180,
+		.end	= 0xe00501ab,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
 		.name	= "GIO_096",
-		.start	= 0xe0050140,
-		.end	= 0xe005015f,
+		.start	= 0xe00501c0,
+		.end	= 0xe00501df,
 		.flags	= IORESOURCE_MEM,
 	},
 	[2] = {
