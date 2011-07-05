From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  5 Jul 2011 12:06:36 +0200
Subject: [PATCH] ARM: mxs/tx28: according to the TX28's datasheet D4-D7 are
	not used for MMC0
Message-ID: <1309860396-9219-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pins are actually used (not in mainline yet):

	D4 -> SSP2_D0
	D5 -> GPIO
	D6 -> GPIO
	D7 -> GPIO for owire

so their pinmapping for SSP0 is wrong.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/mach-tx28.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
index b65e371..068e540 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -101,14 +101,6 @@ static const iomux_cfg_t tx28_stk5v3_pads[] __initconst = {
 		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
 	MX28_PAD_SSP0_DATA3__SSP0_D3 |
 		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_SSP0_DATA4__SSP0_D4 |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_SSP0_DATA5__SSP0_D5 |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_SSP0_DATA6__SSP0_D6 |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_SSP0_DATA7__SSP0_D7 |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
 	MX28_PAD_SSP0_CMD__SSP0_CMD |
 		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
 	MX28_PAD_SSP0_DETECT__SSP0_CARD_DETECT |
-- 
1.7.5.4
