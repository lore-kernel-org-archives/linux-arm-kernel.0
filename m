From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 25 Oct 2018 17:29:31 +0200
Subject: [PATCH RFC 07/11] staging: bcm2835-audio: Enable compile test
In-Reply-To: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1540481375-15952-8-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the compilation test for bcm2835-audio to gain more build coverage.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/staging/vc04_services/bcm2835-audio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/Kconfig b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
index 9f53653..62c1c8b 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Kconfig
+++ b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
@@ -1,6 +1,6 @@
 config SND_BCM2835
         tristate "BCM2835 Audio"
-        depends on ARCH_BCM2835 && SND
+        depends on (ARCH_BCM2835 || COMPILE_TEST) && SND
         select SND_PCM
         select BCM2835_VCHIQ
         help
-- 
2.7.4
