From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 20 Oct 2011 17:21:11 +0530
Subject: [PATCH] ARM: tcc8k: Use CLKDEV_INIT for creating clk_lookup instance
Message-ID: <1319111471-27892-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common macro CLKDEV_INIT was added for creating clk_lookup
instance in include/linux/clkdev.h. So replace _REGISTER_CLOCK
macro with CLKDEV_INIT.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Hans J. Koch <hjk@hansjkoch.de>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-tcc8k/clock.c |  107 ++++++++++++++++++++-----------------------
 1 files changed, 50 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-tcc8k/clock.c b/arch/arm/mach-tcc8k/clock.c
index e7cdae5..6b3dd06 100644
--- a/arch/arm/mach-tcc8k/clock.c
+++ b/arch/arm/mach-tcc8k/clock.c
@@ -468,64 +468,57 @@ DEFINE_BCLOCK(gdma2, BCLKCTR1, 17, NULL, NULL)
 DEFINE_BCLOCK(gdma3, BCLKCTR1, 18, NULL, NULL)
 DEFINE_BCLOCK(ddrc, BCLKCTR1, 19, NULL, NULL)
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
-
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK(NULL, "bus", bus)
-	_REGISTER_CLOCK(NULL, "cpu", cpu)
-	_REGISTER_CLOCK(NULL, "tct", tct)
-	_REGISTER_CLOCK(NULL, "tcx", tcx)
-	_REGISTER_CLOCK(NULL, "tcz", tcz)
-	_REGISTER_CLOCK(NULL, "ref", ref)
-	_REGISTER_CLOCK(NULL, "dai0", dai0)
-	_REGISTER_CLOCK(NULL, "pic", pic)
-	_REGISTER_CLOCK(NULL, "tc", tc)
-	_REGISTER_CLOCK(NULL, "gpio", gpio)
-	_REGISTER_CLOCK(NULL, "usbd", usbd)
-	_REGISTER_CLOCK("tcc-uart.0", NULL, uart0)
-	_REGISTER_CLOCK("tcc-uart.2", NULL, uart2)
-	_REGISTER_CLOCK("tcc-i2c", NULL, i2c)
-	_REGISTER_CLOCK("tcc-uart.3", NULL, uart3)
-	_REGISTER_CLOCK(NULL, "ecc", ecc)
-	_REGISTER_CLOCK(NULL, "adc", adc)
-	_REGISTER_CLOCK("tcc-usbh.0", "usb", usbh0)
-	_REGISTER_CLOCK(NULL, "gdma0", gdma0)
-	_REGISTER_CLOCK(NULL, "lcd", lcd)
-	_REGISTER_CLOCK(NULL, "rtc", rtc)
-	_REGISTER_CLOCK(NULL, "nfc", nfc)
-	_REGISTER_CLOCK("tcc-mmc.0", NULL, sd0)
-	_REGISTER_CLOCK(NULL, "g2d", g2d)
-	_REGISTER_CLOCK(NULL, "gdma1", gdma1)
-	_REGISTER_CLOCK("tcc-uart.1", NULL, uart1)
-	_REGISTER_CLOCK("tcc-spi.0", NULL, spi0)
-	_REGISTER_CLOCK(NULL, "mscl", mscl)
-	_REGISTER_CLOCK("tcc-spi.1", NULL, spi1)
-	_REGISTER_CLOCK(NULL, "bdma", bdma)
-	_REGISTER_CLOCK(NULL, "adma0", adma0)
-	_REGISTER_CLOCK(NULL, "spdif", spdif)
-	_REGISTER_CLOCK(NULL, "scfg", scfg)
-	_REGISTER_CLOCK(NULL, "cid", cid)
-	_REGISTER_CLOCK("tcc-mmc.1", NULL, sd1)
-	_REGISTER_CLOCK("tcc-uart.4", NULL, uart4)
-	_REGISTER_CLOCK(NULL, "dai1", dai1)
-	_REGISTER_CLOCK(NULL, "adma1", adma1)
-	_REGISTER_CLOCK(NULL, "c3dec", c3dec)
-	_REGISTER_CLOCK("tcc-can.0", NULL, can0)
-	_REGISTER_CLOCK("tcc-can.1", NULL, can1)
-	_REGISTER_CLOCK(NULL, "gps", gps)
-	_REGISTER_CLOCK("tcc-gsb.0", NULL, gsb0)
-	_REGISTER_CLOCK("tcc-gsb.1", NULL, gsb1)
-	_REGISTER_CLOCK("tcc-gsb.2", NULL, gsb2)
-	_REGISTER_CLOCK("tcc-gsb.3", NULL, gsb3)
-	_REGISTER_CLOCK(NULL, "gdma2", gdma2)
-	_REGISTER_CLOCK(NULL, "gdma3", gdma3)
-	_REGISTER_CLOCK(NULL, "ddrc", ddrc)
-	_REGISTER_CLOCK("tcc-usbh.1", "usb", usbh1)
+	CLKDEV_INIT(NULL, "bus", &bus),
+	CLKDEV_INIT(NULL, "cpu", &cpu),
+	CLKDEV_INIT(NULL, "tct", &tct),
+	CLKDEV_INIT(NULL, "tcx", &tcx),
+	CLKDEV_INIT(NULL, "tcz", &tcz),
+	CLKDEV_INIT(NULL, "ref", &ref),
+	CLKDEV_INIT(NULL, "dai0", &dai0),
+	CLKDEV_INIT(NULL, "pic", &pic),
+	CLKDEV_INIT(NULL, "tc", &tc),
+	CLKDEV_INIT(NULL, "gpio", &gpio),
+	CLKDEV_INIT(NULL, "usbd", &usbd),
+	CLKDEV_INIT("tcc-uart.0", NULL, &uart0),
+	CLKDEV_INIT("tcc-uart.2", NULL, &uart2),
+	CLKDEV_INIT("tcc-i2c", NULL, &i2c),
+	CLKDEV_INIT("tcc-uart.3", NULL, &uart3),
+	CLKDEV_INIT(NULL, "ecc", &ecc),
+	CLKDEV_INIT(NULL, "adc", &adc),
+	CLKDEV_INIT("tcc-usbh.0", "usb", &usbh0),
+	CLKDEV_INIT(NULL, "gdma0", &gdma0),
+	CLKDEV_INIT(NULL, "lcd", &lcd),
+	CLKDEV_INIT(NULL, "rtc", &rtc),
+	CLKDEV_INIT(NULL, "nfc", &nfc),
+	CLKDEV_INIT("tcc-mmc.0", NULL, &sd0),
+	CLKDEV_INIT(NULL, "g2d", &g2d),
+	CLKDEV_INIT(NULL, "gdma1", &gdma1),
+	CLKDEV_INIT("tcc-uart.1", NULL, &uart1),
+	CLKDEV_INIT("tcc-spi.0", NULL, &spi0),
+	CLKDEV_INIT(NULL, "mscl", &mscl),
+	CLKDEV_INIT("tcc-spi.1", NULL, &spi1),
+	CLKDEV_INIT(NULL, "bdma", &bdma),
+	CLKDEV_INIT(NULL, "adma0", &adma0),
+	CLKDEV_INIT(NULL, "spdif", &spdif),
+	CLKDEV_INIT(NULL, "scfg", &scfg),
+	CLKDEV_INIT(NULL, "cid", &cid),
+	CLKDEV_INIT("tcc-mmc.1", NULL, &sd1),
+	CLKDEV_INIT("tcc-uart.4", NULL, &uart4),
+	CLKDEV_INIT(NULL, "dai1", &dai1),
+	CLKDEV_INIT(NULL, "adma1", &adma1),
+	CLKDEV_INIT(NULL, "c3dec", &c3dec),
+	CLKDEV_INIT("tcc-can.0", NULL, &can0),
+	CLKDEV_INIT("tcc-can.1", NULL, &can1),
+	CLKDEV_INIT(NULL, "gps", &gps),
+	CLKDEV_INIT("tcc-gsb.0", NULL, &gsb0),
+	CLKDEV_INIT("tcc-gsb.1", NULL, &gsb1),
+	CLKDEV_INIT("tcc-gsb.2", NULL, &gsb2),
+	CLKDEV_INIT("tcc-gsb.3", NULL, &gsb3),
+	CLKDEV_INIT(NULL, "gdma2", &gdma2),
+	CLKDEV_INIT(NULL, "gdma3", &gdma3),
+	CLKDEV_INIT(NULL, "ddrc", &ddrc),
+	CLKDEV_INIT("tcc-usbh.1", "usb", &usbh1),
 };
 
 static struct clk *root_clk_by_index(enum root_clks src)
-- 
1.7.4.4
