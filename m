From: x0095840@ti.com (Fernando Guzman Lugo)
Date: Wed, 27 Jan 2010 20:04:02 -0600
Subject: [PATCH] Mailbox: Check valid registered callback before calling
Message-ID: <mailman.218.1266476943.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch checks if the mailbox user has assinged a valid
callback fuction before calling it.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 3e2f961..8136ee3 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -144,7 +144,8 @@ static void mbox_rx_work(struct work_struct *work)
=20
 		msg =3D (mbox_msg_t)rq->special;
 		blk_end_request_all(rq, 0);
-		mbox->rxq->callback((void *)msg);
+		if (mbox->rxq->callback)
+			mbox->rxq->callback((void *)msg);
 	}
 }
=20
--=20
1.6.0.4
