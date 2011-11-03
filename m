From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri,  4 Nov 2011 01:41:22 +0800
Subject: [PATCH 2/2] atmel/spi: fix section missmatch
In-Reply-To: <1320342082-18573-1-git-send-email-plagnioj@jcrosoft.com>
References: <1320342082-18573-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1320342082-18573-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atmel_spi_probe is marked __init where it's supposed to be __devinit

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
---
 drivers/spi/spi-atmel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 3cd4f49..1525262 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -907,7 +907,7 @@ static void atmel_spi_cleanup(struct spi_device *spi)
 
 /*-------------------------------------------------------------------------*/
 
-static int __init atmel_spi_probe(struct platform_device *pdev)
+static int __devinit atmel_spi_probe(struct platform_device *pdev)
 {
 	struct resource		*regs;
 	int			irq;
-- 
1.7.7
