From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 8 Mar 2010 19:38:47 +0100
Subject: [PATCH 2/7] USB: gadget: Increase reset timeout in s3c-hsotg
Message-ID: <b2e8f9f71003081038u74e256c8u355692816fbe7807@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the timeout when waiting for CSftRst to become deasserted.
This removes the "reset failed" message on SmartQ 5/7 machines.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/usb/gadget/s3c-hsotg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 4b5dbd0..6c04c3c 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -2397,7 +2397,7 @@ static int s3c_hsotg_corereset(struct s3c_hsotg *hsotg)
 		return -EINVAL;
 	}

-	timeout = 1000;
+	timeout = 10000;

 	while (1) {
 		u32 grstctl = readl(hsotg->regs + S3C_GRSTCTL);
-- 
1.7.0.1
