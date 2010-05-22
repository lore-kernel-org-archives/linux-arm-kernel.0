From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 22 May 2010 20:14:19 +0300
Subject: [PATCH v3 08/14] omap: mailbox: remove unecessary fields
In-Reply-To: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1274548465-20208-9-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nobody is using them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 0c3c4a5..aad8bf8 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -52,19 +52,11 @@ struct omap_mbox_queue {
 struct omap_mbox {
 	char			*name;
 	unsigned int		irq;
-
 	struct omap_mbox_queue	*txq, *rxq;
-
 	struct omap_mbox_ops	*ops;
-
-	mbox_msg_t		seq_snd, seq_rcv;
-
 	struct device		*dev;
-
 	struct omap_mbox	*next;
 	void			*priv;
-
-	void			(*err_notify)(void);
 };
 
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
-- 
1.7.1
