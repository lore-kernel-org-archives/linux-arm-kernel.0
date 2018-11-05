From: bugalski.piotr@gmail.com (Piotr Bugalski)
Date: Mon,  5 Nov 2018 11:36:20 +0100
Subject: [PATCH v3 1/6] mtd: spi-nor: atmel-quaspi: Typo fix
In-Reply-To: <20181105103625.9644-1-bugalski.piotr@gmail.com>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
Message-ID: <20181105103625.9644-2-bugalski.piotr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just minor typo fix. Fixed in preparation of new driver.

Signed-off: Piotr Bugalski <bugalski.piotr@gmail.com>
---
 drivers/mtd/spi-nor/atmel-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index 820048726b4f..1c5ba8feaa5e 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -67,7 +67,7 @@
 #define QSPI_CR_LASTXFER                BIT(24)
 
 /* Bitfields in QSPI_MR (Mode Register) */
-#define QSPI_MR_SSM                     BIT(0)
+#define QSPI_MR_SMM                     BIT(0)
 #define QSPI_MR_LLB                     BIT(1)
 #define QSPI_MR_WDRBT                   BIT(2)
 #define QSPI_MR_SMRM                    BIT(3)
@@ -563,7 +563,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
 
 	/* Set the QSPI controller in Serial Memory Mode */
-	mr = QSPI_MR_NBBITS(8) | QSPI_MR_SSM;
+	mr = QSPI_MR_NBBITS(8) | QSPI_MR_SMM;
 	qspi_writel(aq, QSPI_MR, mr);
 
 	src_rate = clk_get_rate(aq->clk);
-- 
2.11.0
