From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 12 Oct 2010 14:23:11 +0200
Subject: [PATCH 2/4] clock-mx51: rename CLOCK1 to CLOCK_CCGR for better
	readability
In-Reply-To: <20101012093225.GF29673@pengutronix.d>
References: <20101012093225.GF29673@pengutronix.d>
Message-ID: <1286886193-28960-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx5/clock-mx51.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 7deb683..9a39492 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -772,7 +772,7 @@ static struct clk emi_slow_clk = {
 	.get_rate = clk_emi_slow_get_rate,
 };
 
-#define DEFINE_CLOCK1(name, i, er, es, pfx, p, s)	\
+#define DEFINE_CLOCK_CCGR(name, i, er, es, pfx, p, s)	\
 	static struct clk name = {			\
 		.id		= i,			\
 		.enable_reg	= er,			\
@@ -900,7 +900,7 @@ DEFINE_CLOCK(fec_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG12_OFFSET,
 	NULL,  NULL, &ipg_clk, NULL);
 
 /* NFC */
-DEFINE_CLOCK1(nfc_clk, 0, MXC_CCM_CCGR5, MXC_CCM_CCGRx_CG10_OFFSET,
+DEFINE_CLOCK_CCGR(nfc_clk, 0, MXC_CCM_CCGR5, MXC_CCM_CCGRx_CG10_OFFSET,
 	clk_nfc, &emi_slow_clk, NULL);
 
 /* SSI */
-- 
1.7.0.4
