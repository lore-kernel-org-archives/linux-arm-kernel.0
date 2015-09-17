From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 17 Sep 2015 06:57:59 +0200
Subject: [PATCH v3 10/26] ARM: pxa: magician: Optimize Samsung LCD refresh to
 50Hz
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Message-ID: <55FA4857.5030904@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the default Samsung LCD refresh from an unrealistic 117Hz to 50Hz
as no video applications on the HTC Magician can work that fast.

The optimalization lowers the RAM latency at least by 3%.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 14d1f55..2c487ae 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -317,7 +317,7 @@ static struct pxafb_mode_info toppoly_modes[] = {
 
 static struct pxafb_mode_info samsung_modes[] = {
 	{
-		.pixclock	= 96153,
+		.pixclock	= 226469,
 		.bpp		= 16,
 		.xres		= 240,
 		.yres		= 320,
-- 
1.7.12.1
