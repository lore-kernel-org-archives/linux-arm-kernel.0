From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 22 Mar 2017 19:20:59 +0100
Subject: [PATCH v3 2/5] pata_bk3710: disable IORDY Timer on chipset
 initialization
In-Reply-To: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
References: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170322182135epcas5p3d21d7301da84a5dcb686af4f6817ded9@epcas5p3.samsung.com>
Message-ID: <1490206862-26065-3-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable IORDY Timer as the driver doesn't handle IORDY Timer
interrupt anyway.

Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_bk3710.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_bk3710.c b/drivers/ata/pata_bk3710.c
index 1a1223f..f22e4bf 100644
--- a/drivers/ata/pata_bk3710.c
+++ b/drivers/ata/pata_bk3710.c
@@ -264,9 +264,9 @@ static void pata_bk3710_chipinit(void __iomem *base)
 
 	/*
 	 * IORDYTMP IORDY Timer for Primary Register
-	 * (ATA_IORDYTMP_IORDYTMP     , 0xffff  )
+	 * (ATA_IORDYTMP_IORDYTMP	, DISABLE)
 	 */
-	iowrite32(0xFFFF, base + BK3710_IORDYTMP);
+	iowrite32(0, base + BK3710_IORDYTMP);
 
 	/*
 	 * Configure BMISP Register
-- 
1.9.1
