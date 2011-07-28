From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Thu, 28 Jul 2011 16:29:56 +0200
Subject: [RFC PATCH 7/9] mmc: atmel-mci: use ATMEL_PDC_SCND_BUF_OFF instead of
	a literal value
In-Reply-To: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1311863398-31579-8-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 7955697..c415322 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -603,8 +603,8 @@ static void atmci_pdc_set_single_buf(struct atmel_mci *host,
 	}
 
 	if (buf_nb == PDC_SECOND_BUF) {
-		pointer_reg += 0x10;
-		counter_reg += 0x10;
+		pointer_reg += ATMEL_PDC_SCND_BUF_OFF;
+		counter_reg += ATMEL_PDC_SCND_BUF_OFF;
 	}
 
 	atmci_writel(host, pointer_reg, sg_dma_address(host->sg));
-- 
1.7.0.4
