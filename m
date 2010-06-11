From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 11 Jun 2010 09:20:55 +0100
Subject: [PATCH 09/11] USB: s3c-hsotg: Fix max EP0 IN request length
In-Reply-To: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1276244457-4072-10-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The maximum length for any EP0 IN request on EP0 is 127 bytes, not 128
as the driver currently has it.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/usb/gadget/s3c-hsotg.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 2555f27..17b0779 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -613,8 +613,7 @@ static unsigned get_ep_limit(struct s3c_hsotg_ep *hs_ep)
 		maxpkt = S3C_DxEPTSIZ_PktCnt_LIMIT + 1;
 	} else {
 		if (hs_ep->dir_in) {
-			/* maxsize = S3C_DIEPTSIZ0_XferSize_LIMIT + 1; */
-			maxsize = 64+64+1;
+			maxsize = 64+64;
 			maxpkt = S3C_DIEPTSIZ0_PktCnt_LIMIT + 1;
 		} else {
 			maxsize = 0x3f;
-- 
1.7.0.4
