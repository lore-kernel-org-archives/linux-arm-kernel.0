From: abdallah.meziti.pro@gmail.com (AbdAllah-MEZITI)
Date: Fri, 10 Feb 2017 19:50:50 +0100
Subject: [PATCH v2] staging: bcm2835-audio: fix trailing statements
Message-ID: <20170210185115.2281-1-abdallah.meziti.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trailing statements should be on next line.

Signed-off-by: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>

v2:braces {} should be used on all arms of this statement
---
 drivers/staging/bcm2835-audio/bcm2835-vchiq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
index 6578246..fc9f153 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
@@ -563,7 +563,9 @@ int bcm2835_audio_set_ctls(struct bcm2835_chip *chip)
 			} else if (bcm2835_audio_set_ctls_chan(chip->alsa_stream[i], chip) != 0) {
 				LOG_ERR("Couldn't set the controls for stream %d\n", i);
 				ret = -1;
-			} else LOG_DBG(" Controls set for stream %d\n", i);
+			} else {
+				LOG_DBG(" Controls set for stream %d\n", i);
+			}
 		}
 	}
 	LOG_DBG(" .. OUT ret=%d\n", ret);
-- 
2.9.3
