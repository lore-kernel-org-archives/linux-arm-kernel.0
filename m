From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Thu, 28 Feb 2013 12:29:19 -0600
Subject: [PATCH] mailbox, pl320-ipc: remove __init from probe function
Message-ID: <1362076159-20426-1-git-send-email-mark.langsdorf@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoids a section mismatch.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
---
 drivers/mailbox/pl320-ipc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/pl320-ipc.c b/drivers/mailbox/pl320-ipc.c
index c45b3ae..d873cba 100644
--- a/drivers/mailbox/pl320-ipc.c
+++ b/drivers/mailbox/pl320-ipc.c
@@ -138,8 +138,7 @@ int pl320_ipc_unregister_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(pl320_ipc_unregister_notifier);
 
-static int __init pl320_probe(struct amba_device *adev,
-				const struct amba_id *id)
+static int pl320_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret;
 
-- 
1.7.10.4
