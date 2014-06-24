From: sachin.kamat@samsung.com (Sachin Kamat)
Date: Tue, 24 Jun 2014 17:13:54 +0530
Subject: [PATCH 7/8] ARM: spear: Staticize spear1310_io_desc in spear1310.c
In-Reply-To: <1403610235-22654-1-git-send-email-sachin.kamat@samsung.com>
References: <1403610235-22654-1-git-send-email-sachin.kamat@samsung.com>
Message-ID: <1403610235-22654-7-git-send-email-sachin.kamat@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sachin Kamat <sachin.kamat@linaro.org>

'spear1310_io_desc' is used only in this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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
