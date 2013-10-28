From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Oct 2013 10:16:38 -0700
Subject: [PATCH] ARM: sunxi: remove .init_time hooks
Message-ID: <1382980598-2912-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The machine entries were split up, but the cleanup to remove .init_time
removed the function that the new/split entries refer to. Remove them
since they are no longer needed.

Cc: Maxime Ripard <mripard@free-electrons.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-sunxi/sunxi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index ffac2f53fede..61d3a387f01c 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -134,7 +134,6 @@ static const char * const sun6i_board_dt_compat[] = {
 
 DT_MACHINE_START(SUN6I_DT, "Allwinner sun6i (A31) Family")
 	.init_machine	= sunxi_dt_init,
-	.init_time	= sunxi_timer_init,
 	.dt_compat	= sun6i_board_dt_compat,
 	.restart	= sun6i_restart,
 MACHINE_END
@@ -146,7 +145,6 @@ static const char * const sun7i_board_dt_compat[] = {
 
 DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
 	.init_machine	= sunxi_dt_init,
-	.init_time	= sunxi_timer_init,
 	.dt_compat	= sun7i_board_dt_compat,
 	.restart	= sun4i_restart,
 MACHINE_END
-- 
1.8.4.1.601.g02b3b1d
