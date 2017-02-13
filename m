From: abhijitnaik27@gmail.com (Abhijit Naik)
Date: Tue, 14 Feb 2017 00:42:16 +0530
Subject: [PATCH 1/2] staging: bcm2835-audio: Removed error due to trailing
 statement
Message-ID: <20170213191217.5201-1-abhijitnaik27@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcm2835-vchiq.c:
fixing ERROR: trailing statements should be on next line

Print statement that was on the same line as else statement has been enclosed
within braces and moved to the next line.

Signed-off-by: Abhijit Naik <abhijitnaik27@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835-vchiq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
index c52ac2753898..d11f2cdd1014 100644
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
2.11.0
