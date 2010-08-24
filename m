From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Tue, 24 Aug 2010 17:27:03 +0200
Subject: [PATCH 2/2] mx35_3ds: Make usage of the display connection feature
In-Reply-To: <1282643200-13332-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1282643200-13332-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1282663623-8404-3-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Beisert <jbe@pengutronix.de>

This platform uses a 18 bpp display.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx35_3ds.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 60d5753..ba65463 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -75,6 +75,21 @@ static struct mx3fb_platform_data mx3fb_pdata = {
 	.name		= "CTP-CLAA070LC0ACW",
 	.mode		= fb_personality,
 	.num_modes	= ARRAY_SIZE(fb_personality),
+	/* D[12..17] red */
+	.red = {
+		.offset = 12,
+		.length = 6,
+	},
+	/* D[6..11] green */
+	.green = {
+		.offset = 6,
+		.length = 6,
+	},
+	/* D[0..5] blue */
+	.blue = {
+		.offset = 0,
+		.length = 6,
+	},
 };
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
-- 
1.7.1
