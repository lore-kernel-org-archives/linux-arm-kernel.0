From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 15 May 2012 21:58:18 +0800
Subject: [PATCH v1 2/7] usb: chipidea: remove zero check of hw_ep_max
In-Reply-To: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337090303-16046-3-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's 0 for host only device.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index f568b8e..15e03b3 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -195,7 +195,7 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
 		ffs_nr(DCCPARAMS_DEN);
 	ci->hw_ep_max = reg * 2;   /* cache hw ENDPT_MAX */
 
-	if (ci->hw_ep_max == 0 || ci->hw_ep_max > ENDPT_MAX)
+	if (ci->hw_ep_max > ENDPT_MAX)
 		return -ENODEV;
 
 	dev_dbg(ci->dev, "ChipIdea HDRC found, lpm: %d; cap: %p op: %p\n",
-- 
1.7.5.4
