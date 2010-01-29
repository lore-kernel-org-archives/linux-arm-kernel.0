From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 04:14:16 +0000
Subject: [PATCH] ARM: S3C2412: SoC has the fractional baud rate register
In-Reply-To: <1264738459-1972-1-git-send-email-ben-linux@fluff.org>
References: <1264738459-1972-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264738459-1972-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michel Pollet <buserror@gmail.com>

The S3C2412 has a fractional baud rate register, this patch adds the
corresponding flag to the UART definition to allow generation of more
precise baud rates for the various clock combinations.

Signed-off-by: Michel Pollet <buserror@gmail.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/serial/s3c2412.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/s3c2412.c b/drivers/serial/s3c2412.c
index ce75e28..1700b1a 100644
--- a/drivers/serial/s3c2412.c
+++ b/drivers/serial/s3c2412.c
@@ -102,6 +102,7 @@ static struct s3c24xx_uart_info s3c2412_uart_inf = {
 	.name		= "Samsung S3C2412 UART",
 	.type		= PORT_S3C2412,
 	.fifosize	= 64,
+	.has_divslot	= 1,
 	.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
 	.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
 	.rx_fifofull	= S3C2440_UFSTAT_RXFULL,
-- 
1.6.0.4
