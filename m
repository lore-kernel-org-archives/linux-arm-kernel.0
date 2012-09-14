From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 23:34:50 +0200
Subject: [PATCH 22/24] scsi: eesox: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-1-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
Message-ID: <1347658492-11608-23-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM is moving to stricter checks on readl/write functions,
so we need to use the correct types everywhere.

Cc: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: linux-scsi at vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/arm/eesox.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arm/eesox.c b/drivers/scsi/arm/eesox.c
index edfd12b..968d083 100644
--- a/drivers/scsi/arm/eesox.c
+++ b/drivers/scsi/arm/eesox.c
@@ -273,7 +273,7 @@ static void eesoxscsi_buffer_out(void *buf, int length, void __iomem *base)
 {
 	const void __iomem *reg_fas = base + EESOX_FAS216_OFFSET;
 	const void __iomem *reg_dmastat = base + EESOX_DMASTAT;
-	const void __iomem *reg_dmadata = base + EESOX_DMADATA;
+	void __iomem *reg_dmadata = base + EESOX_DMADATA;
 
 	do {
 		unsigned int status;
-- 
1.7.10
