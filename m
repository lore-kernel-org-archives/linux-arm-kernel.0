From: abhijitnaik27@gmail.com (Abhijit Naik)
Date: Fri, 10 Feb 2017 17:09:05 +0530
Subject: [PATCH] staging: bcm2835-audio: Fixed initialization of global to
 "false"
Message-ID: <20170210113905.17284-1-abhijitnaik27@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcm2835-vchiq.c:
fixing ERROR: do not initialise globals to false

Instead of explicitly initializing global variable force_bulk to "false",
declared force_bulk as static variable.

Signed-off-by: Abhijit Naik <abhijitnaik27@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835-vchiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
index 9ac1f72a178e..5f3d89fbb73c 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
@@ -65,7 +65,7 @@ struct bcm2835_audio_instance {
 	short peer_version;
 };

-bool force_bulk = false;
+static bool force_bulk;

 /* ---- Private Variables ---------------------------------------------------- */

--
2.11.0
