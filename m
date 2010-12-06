From: marek.belisko@open-nandra.com (Marek Belisko)
Date: Mon,  6 Dec 2010 15:04:03 +0100
Subject: [PATCH] arm: ecard: Fix compilation warning.
Message-ID: <1291644243-23540-1-git-send-email-marek.belisko@open-nandra.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following compilation warning:
arch/arm/kernel/ecard.c:1066: warning: ignoring return value of
'device_register', declared with attribute warn_unused_result

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
---
 arch/arm/kernel/ecard.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/ecard.c b/arch/arm/kernel/ecard.c
index eed2f79..da882b1 100644
--- a/arch/arm/kernel/ecard.c
+++ b/arch/arm/kernel/ecard.c
@@ -1063,8 +1063,10 @@ ecard_probe(int slot, card_type_t type)
 	*ecp = ec;
 	slot_to_expcard[slot] = ec;
 
-	device_register(&ec->dev);
-
+	rc = device_register(&ec->dev);
+	if (rc)
+		goto nodev;
+
 	return 0;
 
  nodev:
-- 
1.7.1
