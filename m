From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Jul 2013 13:35:54 +0900
Subject: [PATCH 2/2] ARM: shmobile: emev2 GIO3 resource fix
In-Reply-To: <cover.1372739438.git.horms+renesas@verge.net.au>
References: <cover.1372739438.git.horms+renesas@verge.net.au>
Message-ID: <1eb14ea1e6bcd11d6d0ba937fc39808bb4d3453e.1372739438.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Fix GIO3 base addresses for EMEV2.

This bug was introduced by 088efd9273b5076a0aead479aa31f1066d182b3e
("mach-shmobile: Emma Mobile EV2 GPIO support V3") which was included in v3.5.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Cc: stable at vger.kernel.org
---
 arch/arm/mach-shmobile/setup-emev2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 899a86c..1ccddd2 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -287,14 +287,14 @@ static struct gpio_em_config gio3_config = {
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
-- 
1.8.2.1
