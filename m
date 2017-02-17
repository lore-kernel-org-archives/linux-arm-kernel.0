From: adanhawthorn@gmail.com (Nathan Howard)
Date: Fri, 17 Feb 2017 15:16:19 -0500
Subject: [PATCH 3/5] staging: bcm2835-audio: bcm2835.h: fix macro coding style
 issue
In-Reply-To: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
References: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
Message-ID: <1487362603-15967-3-git-send-email-adanhawthorn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix checkpatch.pl warning of the form "CHECK: Macro argument 'vol' may be
better as '(vol)' to avoid precedence issues."

Signed-off-by: Nathan Howard <adanhawthorn@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835.h b/drivers/staging/bcm2835-audio/bcm2835.h
index 81fdb10..2f9d1c9 100644
--- a/drivers/staging/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/bcm2835-audio/bcm2835.h
@@ -77,8 +77,11 @@ enum {
 
 /* macros for alsa2chip and chip2alsa, instead of functions */
 
-#define alsa2chip(vol) (uint)(-((vol << 8) / 100)) /* convert alsa to chip volume (defined as macro rather than function call) */
-#define chip2alsa(vol) -((vol * 100) >> 8)   /* convert chip to alsa volume */
+// convert alsa to chip volume (defined as macro rather than function call)
+#define alsa2chip(vol) (uint)(-(((vol) << 8) / 100))
+
+// convert chip to alsa volume
+#define chip2alsa(vol) -(((vol) * 100) >> 8)
 
 /* Some constants for values .. */
 enum snd_bcm2835_route {
-- 
2.7.4
