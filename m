From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 30 May 2014 16:07:39 +0530
Subject: [PATCH Resend 6/8] ARM: spear: Staticize spear13xx_io_desc
In-Reply-To: <1401446261-22423-1-git-send-email-sachin.kamat@linaro.org>
References: <1401446261-22423-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1401446261-22423-6-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'spear13xx_io_desc' is used only in this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: spear-devel at list.st.com
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
