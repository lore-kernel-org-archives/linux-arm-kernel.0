From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 28 May 2014 11:30:31 +0530
Subject: [PATCH 1/1] ARM: spear: Staticize spear13xx_io_desc
Message-ID: <1401256831-6874-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'spear13xx_io_desc' is used only in this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-spear/spear13xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index c9897ea38980..8b56fe61a492 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -57,7 +57,7 @@ void __init spear13xx_l2x0_init(void)
  * 0xEC000000		0xFC000000
  * 0xED000000		0xFB000000
  */
-struct map_desc spear13xx_io_desc[] __initdata = {
+static struct map_desc spear13xx_io_desc[] __initdata = {
 	{
 		.virtual	= (unsigned long)VA_PERIP_GRP2_BASE,
 		.pfn		= __phys_to_pfn(PERIP_GRP2_BASE),
-- 
1.7.9.5
