From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 28 May 2014 14:57:59 +0530
Subject: [PATCH 1/2] ARM: spear: Staticize spear1310_io_desc in spear1310.c
Message-ID: <1401269280-3567-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'spear1310_io_desc' is used only in this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-spear/spear1310.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear/spear1310.c b/arch/arm/mach-spear/spear1310.c
index 824b12a56a42..d9ce4d8000f0 100644
--- a/arch/arm/mach-spear/spear1310.c
+++ b/arch/arm/mach-spear/spear1310.c
@@ -42,7 +42,7 @@ static const char * const spear1310_dt_board_compat[] = {
  * PHYSICAL		VIRTUAL
  * 0xD8000000		0xFA000000
  */
-struct map_desc spear1310_io_desc[] __initdata = {
+static struct map_desc spear1310_io_desc[] __initdata = {
 	{
 		.virtual	= VA_SPEAR1310_RAS_GRP1_BASE,
 		.pfn		= __phys_to_pfn(SPEAR1310_RAS_GRP1_BASE),
-- 
1.7.9.5
