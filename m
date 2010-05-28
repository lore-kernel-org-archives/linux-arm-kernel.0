From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 28 May 2010 13:42:17 +0200
Subject: [PATCH 3/4] mx35: adjust flexcan clock definition
In-Reply-To: <1275046938-8465-1-git-send-email-mkl@pengutronix.de>
References: <1275046938-8465-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1275046938-8465-4-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx35.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 9f3e943..ba4e722 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -428,8 +428,8 @@ static struct clk nfc_clk = {
 static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "asrc", asrc_clk)
 	_REGISTER_CLOCK(NULL, "ata", ata_clk)
-	_REGISTER_CLOCK(NULL, "can", can1_clk)
-	_REGISTER_CLOCK(NULL, "can", can2_clk)
+	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
+	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
 	_REGISTER_CLOCK("spi_imx.0", NULL, cspi1_clk)
 	_REGISTER_CLOCK("spi_imx.1", NULL, cspi2_clk)
 	_REGISTER_CLOCK(NULL, "ect", ect_clk)
-- 
1.7.1
