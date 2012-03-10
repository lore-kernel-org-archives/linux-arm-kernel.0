From: lost.distance@yahoo.com (Paul Parsons)
Date: Sat, 10 Mar 2012 18:11:20 +0000 (GMT)
Subject: [PATCH] pxa/hx4700: Reduce sleep mode power consumption by 35%
Message-ID: <1331403080.2319.YahooMailClassic@web29002.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drive the two Bluetooth UART output GPIOs (GPIO43_BTUART_TXD, GPIO45_BTUART_RTS)
LOW during sleep mode instead of HIGH. This reduces sleep mode power consumption
from approximately 46 mA/h to approximately 30 mA/h.

Signed-off-by: Oliver Winker <oliver@oli1170.net>
Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

Thanks to Oliver Winker for finding this.

diff -uprN clean-3.3-rc6/arch/arm/mach-pxa/hx4700.c linux-3.3-rc6/arch/arm/mach-pxa/hx4700.c
--- clean-3.3-rc6/arch/arm/mach-pxa/hx4700.c	2012-03-04 01:08:09.000000000 +0000
+++ linux-3.3-rc6/arch/arm/mach-pxa/hx4700.c	2012-03-10 15:44:18.597238757 +0000
@@ -97,9 +97,9 @@ static unsigned long hx4700_pin_config[]
 
 	/* BTUART */
 	GPIO42_BTUART_RXD,
-	GPIO43_BTUART_TXD,
+	GPIO43_GPIO | MFP_AF2 | MFP_LPM_DRIVE_LOW,
 	GPIO44_BTUART_CTS,
-	GPIO45_BTUART_RTS,
+	GPIO45_GPIO | MFP_AF2 | MFP_LPM_DRIVE_LOW,
 
 	/* PWM 1 (Backlight) */
 	GPIO17_PWM1_OUT,
