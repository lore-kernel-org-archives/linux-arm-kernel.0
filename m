From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 02 Dec 2009 21:55:20 +0800
Subject: [PATCH 3/4]ARM: NUC900: enable timer clock for nuc932
Message-ID: <4B1671C8.1030205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

This patch enables timer clock support for nuc932.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 arch/arm/mach-w90x900/time_932.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-w90x900/time_932.c b/arch/arm/mach-w90x900/time_932.c
index c50f9c0..3f315fe 100644
--- a/arch/arm/mach-w90x900/time_932.c
+++ b/arch/arm/mach-w90x900/time_932.c
@@ -38,10 +38,12 @@
 static void __init nuc900_timer_init(void)
 {
 	struct clk *ck_ext = clk_get(NULL, "ext");
+	struct clk *ck_timer = clk_get(NULL, "timer");
 	unsigned int	rate;
 
-	BUG_ON(IS_ERR(ck_ext));
+	BUG_ON(IS_ERR(ck_ext) || IS_ERR(ck_timer));
 
+	clk_enable(ck_timer);
 	rate = clk_get_rate(ck_ext);
 	clk_put(ck_ext);
 	rate = rate / (PRESCALE + 0x01);
-- 
1.5.6.3
