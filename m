From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Tue, 17 Jul 2018 11:26:56 +0300
Subject: [PATCH 3/4] ARM: at91: pm: add PMC fast startup registers defines
In-Reply-To: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
References: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1531816017-31986-4-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PMC fast startup registers defines.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/linux/clk/at91_pmc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 4ea2cbf9b50d..931ab05f771d 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -157,6 +157,19 @@
 #define		AT91_PMC_GCKRDY		(1 << 24)		/* Generated Clocks */
 #define	AT91_PMC_IMR		0x6c			/* Interrupt Mask Register */
 
+#define AT91_PMC_FSMR		0x70		/* Fast Startup Mode Register */
+#define AT91_PMC_FSTT(n)	BIT(n)
+#define AT91_PMC_RTCAL		BIT(17)		/* RTC Alarm Enable */
+#define AT91_PMC_USBAL		BIT(18)		/* USB Resume Enable */
+#define AT91_PMC_SDMMC_CD	BIT(19)		/* SDMMC Card Detect Enable */
+#define AT91_PMC_LPM		BIT(20)		/* Low-power Mode */
+#define AT91_PMC_RXLP_MCE	BIT(24)		/* Backup UART Receive Enable */
+#define AT91_PMC_ACC_CE		BIT(25)		/* ACC Enable */
+
+#define AT91_PMC_FSPR		0x74		/* Fast Startup Polarity Reg */
+
+#define AT91_PMC_FS_INPUT_MASK  0x7ff
+
 #define AT91_PMC_PLLICPR	0x80			/* PLL Charge Pump Current Register */
 
 #define AT91_PMC_PROT		0xe4			/* Write Protect Mode Register [some SAM9] */
-- 
2.7.4
