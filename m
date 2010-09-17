From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 17 Sep 2010 11:54:30 +0200
Subject: [PATCH 12/16] ARM: mx5/clock-mx51: new macro that defines a clk with
	all members
In-Reply-To: <20100917095247.GB30441@pengutronix.de>
References: <20100917095247.GB30441@pengutronix.de>
Message-ID: <1284717274-12850-12-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/clock-mx51.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index fe658bf..0e39698 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -764,21 +764,21 @@ static struct clk kpp_clk = {
 	.id = 0,
 };
 
-#define DEFINE_CLOCK(name, i, er, es, gr, sr, p, s)	\
-	static struct clk name = {			\
-		.id		= i,			\
-		.enable_reg	= er,			\
-		.enable_shift	= es,			\
-		.get_rate	= gr,			\
-		.set_rate	= sr,			\
-		.enable		= _clk_ccgr_enable,	\
-		.disable	= _clk_ccgr_disable,	\
-		.parent		= p,			\
-		.secondary	= s,			\
+#define DEFINE_CLOCK_FULL(name, i, er, es, gr, sr, e, d, p, s)		\
+	static struct clk name = {					\
+		.id		= i,					\
+		.enable_reg	= er,					\
+		.enable_shift	= es,					\
+		.get_rate	= gr,					\
+		.set_rate	= sr,					\
+		.enable		= e,					\
+		.disable	= d,					\
+		.parent		= p,					\
+		.secondary	= s,					\
 	}
 
-/* DEFINE_CLOCK(name, id, enable_reg, enable_shift,
-   get_rate, set_rate, parent, secondary); */
+#define DEFINE_CLOCK(name, i, er, es, gr, sr, p, s)			\
+	DEFINE_CLOCK_FULL(name, i, er, es, gr, sr, _clk_ccgr_enable, _clk_ccgr_disable, p, s)
 
 /* Shared peripheral bus arbiter */
 DEFINE_CLOCK(spba_clk, 0, MXC_CCM_CCGR5, MXC_CCM_CCGRx_CG0_OFFSET,
-- 
1.7.2.3
