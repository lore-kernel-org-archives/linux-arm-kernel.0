From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 29 Sep 2010 14:51:29 +0200
Subject: [PATCH] amba-pl011: add missing ST specific registers
Message-ID: <1285764689-4772-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

The ST Micro derivates have several extra interesting registers
that we may soon use for something interesting so may just as
well define them in the header.

Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 include/linux/amba/serial.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index e1b634b..6021588 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -32,7 +32,9 @@
 #define UART01x_RSR		0x04	/* Receive status register (Read). */
 #define UART01x_ECR		0x04	/* Error clear register (Write). */
 #define UART010_LCRH		0x08	/* Line control register, high byte. */
+#define ST_UART011_DMAWM	0x08    /* DMA watermark configure register. */
 #define UART010_LCRM		0x0C	/* Line control register, middle byte. */
+#define ST_UART011_TIMEOUT	0x0C    /* Timeout period register. */
 #define UART010_LCRL		0x10	/* Line control register, low byte. */
 #define UART010_CR		0x14	/* Control register. */
 #define UART01x_FR		0x18	/* Flag register (Read only). */
@@ -51,6 +53,15 @@
 #define UART011_MIS		0x40	/* Masked interrupt status. */
 #define UART011_ICR		0x44	/* Interrupt clear register. */
 #define UART011_DMACR		0x48	/* DMA control register. */
+#define ST_UART011_XFCR		0x50	/* XON/XOFF control register. */
+#define ST_UART011_XON1		0x54	/* XON1 register. */
+#define ST_UART011_XON2		0x58	/* XON2 register. */
+#define ST_UART011_XOFF1	0x5C	/* XON1 register. */
+#define ST_UART011_XOFF2	0x60	/* XON2 register. */
+#define ST_UART011_ITCR		0x80	/* Integration test control register. */
+#define ST_UART011_ITIP		0x84	/* Integration test input register. */
+#define ST_UART011_ABCR		0x100	/* Autobaud control register. */
+#define ST_UART011_ABIMSC	0x15C	/* Autobaud interrupt mask/clear register. */
 
 #define UART011_DR_OE		(1 << 11)
 #define UART011_DR_BE		(1 << 10)
-- 
1.6.3.3
