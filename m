From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 24 Nov 2014 16:17:14 -0800
Subject: [PATCH V6 02/12] mailbox: Make struct mbox_controller's ops field
 const
In-Reply-To: <1416874644-12070-1-git-send-email-abrestic@chromium.org>
References: <1416874644-12070-1-git-send-email-abrestic@chromium.org>
Message-ID: <1416874644-12070-3-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mailbox controller's channel ops ought to be read-only.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
No changes from v5.
New for v5.
---
 include/linux/mailbox_controller.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index d4cf96f..68c4245 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -72,7 +72,7 @@ struct mbox_chan_ops {
  */
 struct mbox_controller {
 	struct device *dev;
-	struct mbox_chan_ops *ops;
+	const struct mbox_chan_ops *ops;
 	struct mbox_chan *chans;
 	int num_chans;
 	bool txdone_irq;
-- 
2.1.0.rc2.206.gedb03e5
