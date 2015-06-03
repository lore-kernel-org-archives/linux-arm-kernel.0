From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 3 Jun 2015 11:04:23 +0200
Subject: [PATCH v4 2/6] i2c: at91: use BIT() macro to define register bits
In-Reply-To: <cover.1433321260.git.cyrille.pitchen@atmel.com>
References: <cover.1433321260.git.cyrille.pitchen@atmel.com>
Message-ID: <45e14b45987fd18986aebfa08c67044433149457.1433321260.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch just fixes typo before applying later patches which will use
register bits with index above 16.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 9bd10a9..0e88b68 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -41,29 +41,30 @@
 
 /* AT91 TWI register definitions */
 #define	AT91_TWI_CR		0x0000	/* Control Register */
-#define	AT91_TWI_START		0x0001	/* Send a Start Condition */
-#define	AT91_TWI_STOP		0x0002	/* Send a Stop Condition */
-#define	AT91_TWI_MSEN		0x0004	/* Master Transfer Enable */
-#define	AT91_TWI_SVDIS		0x0020	/* Slave Transfer Disable */
-#define	AT91_TWI_QUICK		0x0040	/* SMBus quick command */
-#define	AT91_TWI_SWRST		0x0080	/* Software Reset */
+#define	AT91_TWI_START		BIT(0)	/* Send a Start Condition */
+#define	AT91_TWI_STOP		BIT(1)	/* Send a Stop Condition */
+#define	AT91_TWI_MSEN		BIT(2)	/* Master Transfer Enable */
+#define	AT91_TWI_MSDIS		BIT(3)	/* Master Transfer Disable */
+#define	AT91_TWI_SVEN		BIT(4)	/* Slave Transfer Enable */
+#define	AT91_TWI_SVDIS		BIT(5)	/* Slave Transfer Disable */
+#define	AT91_TWI_QUICK		BIT(6)	/* SMBus quick command */
+#define	AT91_TWI_SWRST		BIT(7)	/* Software Reset */
 
 #define	AT91_TWI_MMR		0x0004	/* Master Mode Register */
 #define	AT91_TWI_IADRSZ_1	0x0100	/* Internal Device Address Size */
-#define	AT91_TWI_MREAD		0x1000	/* Master Read Direction */
+#define	AT91_TWI_MREAD		BIT(12)	/* Master Read Direction */
 
 #define	AT91_TWI_IADR		0x000c	/* Internal Address Register */
 
 #define	AT91_TWI_CWGR		0x0010	/* Clock Waveform Generator Reg */
 
 #define	AT91_TWI_SR		0x0020	/* Status Register */
-#define	AT91_TWI_TXCOMP		0x0001	/* Transmission Complete */
-#define	AT91_TWI_RXRDY		0x0002	/* Receive Holding Register Ready */
-#define	AT91_TWI_TXRDY		0x0004	/* Transmit Holding Register Ready */
-
-#define	AT91_TWI_OVRE		0x0040	/* Overrun Error */
-#define	AT91_TWI_UNRE		0x0080	/* Underrun Error */
-#define	AT91_TWI_NACK		0x0100	/* Not Acknowledged */
+#define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
+#define	AT91_TWI_RXRDY		BIT(1)	/* Receive Holding Register Ready */
+#define	AT91_TWI_TXRDY		BIT(2)	/* Transmit Holding Register Ready */
+#define	AT91_TWI_OVRE		BIT(6)	/* Overrun Error */
+#define	AT91_TWI_UNRE		BIT(7)	/* Underrun Error */
+#define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
 
 #define	AT91_TWI_INT_MASK \
 	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK)
-- 
1.8.2.2
