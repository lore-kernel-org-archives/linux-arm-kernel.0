From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Thu, 11 Aug 2011 17:25:46 +0200
Subject: [PATCH v2 6/8] mmc: atmel-mci: use ATMEL_PDC_SCND_BUF_OFF instead of
	a literal value
In-Reply-To: <1313076348-3065-1-git-send-email-ludovic.desroches@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
	<1313076348-3065-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <4c1ea9367961693efff27ea30217ee1f46995bd4.1313071126.git.ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    4 ++--
 include/linux/atmel_pdc.h    |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

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
diff --git a/include/linux/atmel_pdc.h b/include/linux/atmel_pdc.h
index 5058a31..63499ce 100644
--- a/include/linux/atmel_pdc.h
+++ b/include/linux/atmel_pdc.h
@@ -33,4 +33,6 @@
 
 #define ATMEL_PDC_PTSR		0x124	/* Transfer Status Register */
 
+#define ATMEL_PDC_SCND_BUF_OFF	0x10	/* Offset between first and second buffer registers */
+
 #endif
-- 
1.7.0.4
