From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 12 Nov 2018 04:20:22 +0100
Subject: [PATCH v3 13/18] ARM: mmp2: initialize clocks before the timer
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
Message-ID: <20181112032027.653931-14-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer shall enable its clock.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/mach-mmp/mmp2-dt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 0341359b24a4..50c5e8b5be3d 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -26,8 +26,8 @@ static void __init mmp_init_time(void)
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init(0);
 #endif
-	mmp_dt_init_timer();
 	of_clk_init(NULL);
+	mmp_dt_init_timer();
 }
 
 static const char *const mmp2_dt_board_compat[] __initconst = {
-- 
2.19.1
