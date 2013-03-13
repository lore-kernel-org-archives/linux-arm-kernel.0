From: s-anna@ti.com (Suman Anna)
Date: Tue, 12 Mar 2013 22:24:23 -0500
Subject: [PATCHv3 09/14] mailbox: add IRQF_NO_SUSPEND flag
Message-ID: <1363145063-14647-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Loic Pallardy <loic.pallardy@st.com>

Coprocessor must be accessible during suspend transitions.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mailbox/mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 08da5b0..35813f5 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -311,7 +311,8 @@ static int mailbox_startup(struct mailbox *mbox)
 	}
 
 	if (!mbox->use_count++) {
-		ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
+		ret = request_irq(mbox->irq, mbox_interrupt,
+				IRQF_SHARED | IRQF_NO_SUSPEND,
 				mbox->name, mbox);
 		if (unlikely(ret)) {
 			pr_err("failed to register mailbox interrupt:%d\n",
-- 
1.8.1.2
