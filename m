From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 3 Sep 2012 15:10:23 +0200
Subject: [PATCH] ARM: ux500: Correct Ux500 family names usage
Message-ID: <1346677823-28158-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Loic PALLARDY <loic.pallardy@st.com>

Update users with cpu_is_ux540_family() to keep x540
family functional.

Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Arnd, Olof:

This patch goes on top of the ux500-asicid patches pulled earlier,
into your ux500/asic-id branch, it'd be best if you just applied
this one on top manually. If you prefer I can send a new pull
request from the same branch.

Linus
---
 arch/arm/mach-ux500/clock.c   | 2 +-
 arch/arm/mach-ux500/platsmp.c | 2 +-
 arch/arm/mach-ux500/timer.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 8d73b06..bc5a516 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -149,7 +149,7 @@ static unsigned long clk_mtu_get_rate(struct clk *clk)
 	unsigned long mturate;
 	unsigned long retclk;
 
-	if (cpu_is_u8500_family())
+	if (cpu_is_u8500_family() || cpu_is_ux540_family())
 		addr = __io_address(U8500_PRCMU_BASE);
 	else
 		ux500_unknown_soc();
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index cb35897..a5dda684 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -118,7 +118,7 @@ static void __init wakeup_secondary(void)
 {
 	void __iomem *backupram;
 
-	if (cpu_is_u8500_family())
+	if (cpu_is_u8500_family() || cpu_is_ux540_family())
 		backupram = __io_address(U8500_BACKUPRAM0_BASE);
 	else
 		ux500_unknown_soc();
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index 66e7f00..6f39731 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -54,7 +54,7 @@ static void __init ux500_timer_init(void)
 	void __iomem *tmp_base;
 	struct device_node *np;
 
-	if (cpu_is_u8500_family()) {
+	if (cpu_is_u8500_family() || cpu_is_ux540_family()) {
 		mtu_timer_base = __io_address(U8500_MTU0_BASE);
 		prcmu_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
 	} else {
-- 
1.7.11.3
