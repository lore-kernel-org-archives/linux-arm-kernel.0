From: sachin.kamat@samsung.com (Sachin Kamat)
Date: Tue, 24 Jun 2014 17:13:53 +0530
Subject: [PATCH 6/8] ARM: spear: Staticize spear13xx_io_desc
In-Reply-To: <1403610235-22654-1-git-send-email-sachin.kamat@samsung.com>
References: <1403610235-22654-1-git-send-email-sachin.kamat@samsung.com>
Message-ID: <1403610235-22654-6-git-send-email-sachin.kamat@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sachin Kamat <sachin.kamat@linaro.org>

'spear13xx_io_desc' is used only in this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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
