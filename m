From: stigge@antcom.de (Roland Stigge)
Date: Tue, 25 Sep 2012 09:56:13 +0200
Subject: [PATCH 1/2] gpio-lpc32xx: Add GPI_28
Message-ID: <1348559774-15484-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing gpi28 to the list of GPIOs in the GPI P3 "chip".

NOTE: This patch depends on incrementing LPC32XX_GPI_P3_MAX.  When applied
without the respective mach-lpc32xx patch (merged via arm-soc.git), gcc will
give a warning about "excess elements in array initializer" but this doesn't
harm.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 arch/arm/mach-lpc32xx/include/mach/gpio-lpc32xx.h |    2 +-
 drivers/gpio/gpio-lpc32xx.c                       |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.orig/drivers/gpio/gpio-lpc32xx.c
+++ linux-2.6/drivers/gpio/gpio-lpc32xx.c
@@ -113,7 +113,8 @@ static const char *gpi_p3_names[LPC32XX_
 	 NULL,    NULL,    NULL,   "gpi15",
 	"gpi16", "gpi17", "gpi18", "gpi19",
 	"gpi20", "gpi21", "gpi22", "gpi23",
-	"gpi24", "gpi25", "gpi26", "gpi27"
+	"gpi24", "gpi25", "gpi26", "gpi27",
+	"gpi28"
 };
 
 static const char *gpo_p3_names[LPC32XX_GPO_P3_MAX] = {
