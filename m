From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 11 Jun 2010 09:20:56 +0100
Subject: [PATCH 10/11] USB: s3c-hsotg: Fix the OUT EP0 limit
In-Reply-To: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1276244457-4072-11-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EP0 out limit is the same as the IN limit, so make them the same.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

tmp-fix
---
 drivers/usb/gadget/s3c-hsotg.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 17b0779..b34a05d 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -612,11 +612,10 @@ static unsigned get_ep_limit(struct s3c_hsotg_ep *hs_ep)
 		maxsize = S3C_DxEPTSIZ_XferSize_LIMIT + 1;
 		maxpkt = S3C_DxEPTSIZ_PktCnt_LIMIT + 1;
 	} else {
+		maxsize = 64+64;
 		if (hs_ep->dir_in) {
-			maxsize = 64+64;
 			maxpkt = S3C_DIEPTSIZ0_PktCnt_LIMIT + 1;
 		} else {
-			maxsize = 0x3f;
 			maxpkt = 2;
 		}
 	}
-- 
1.7.0.4
