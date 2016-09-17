From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:36:27 +0200
Subject: [PATCH 24/24] ste_dma40: Rename a jump label in d40_log_lli_to_lcxa()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <b28fbc00-5643-ba77-c94a-dbfe14618a9b@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 16:39:06 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 01fe3a2..dcb26c6 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -874,7 +874,7 @@ static void d40_log_lli_to_lcxa(struct d40_chan *chan, struct d40_desc *desc)
 	}
 
 	if (curr_lcla < 0)
-		goto out;
+		goto set_current;
 
 	for (; lli_current < lli_len; lli_current++) {
 		unsigned int lcla_offset = chan->phy_chan->num * 1024 +
@@ -925,8 +925,7 @@ static void d40_log_lli_to_lcxa(struct d40_chan *chan, struct d40_desc *desc)
 			break;
 		}
 	}
-
-out:
+ set_current:
 	desc->lli_current = lli_current;
 }
 
-- 
2.10.0
