From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Tue, 4 Aug 2015 09:09:42 +0000
Subject: [PATCH 3/9] usb: musb: musb_dsps: Simplify return statement
In-Reply-To: <cover.1438678566.git.skarajga@visteon.com>
References: <cover.1438678566.git.skarajga@visteon.com>
Message-ID: <0484e5c9da0a2f46386c79115be618f228b42443.1438678566.git.skarajga@visteon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saurabh Karajgaonkar <skarajga@visteon.com>

Replace redundant variable use in return statement.

Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
---
 drivers/usb/musb/musb_dsps.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 1334a3d..a0cfead 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -482,11 +482,7 @@ static int dsps_musb_init(struct musb *musb)
 		dsps_writeb(musb->mregs, MUSB_BABBLE_CTL, val);
 	}
 
-	ret = dsps_musb_dbg_init(musb, glue);
-	if (ret)
-		return ret;
-
-	return 0;
+	return dsps_musb_dbg_init(musb, glue);
 }
 
 static int dsps_musb_exit(struct musb *musb)
-- 
1.9.1
