From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 30 May 2014 16:07:40 +0530
Subject: [PATCH Resend 7/8] ARM: spear: Staticize spear1310_io_desc in
 spear1310.c
In-Reply-To: <1401446261-22423-1-git-send-email-sachin.kamat@linaro.org>
References: <1401446261-22423-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1401446261-22423-7-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'spear1310_io_desc' is used only in this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: spear-devel at list.st.com
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
