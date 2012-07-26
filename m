From: javier.martin@vista-silicon.com (Javier Martin)
Date: Thu, 26 Jul 2012 13:20:35 +0200
Subject: [PATCH 2/4] media: mx2_camera: Mark i.MX25 support as BROKEN.
In-Reply-To: <1343301637-19676-1-git-send-email-javier.martin@vista-silicon.com>
References: <1343301637-19676-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1343301637-19676-3-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX25 support is known to have been broken for
almost a year.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 drivers/media/video/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index c0b9233..af9d2d0 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -1136,7 +1136,7 @@ config VIDEO_MX2_HOSTSUPPORT
 
 config VIDEO_MX2
 	tristate "i.MX27/i.MX25 Camera Sensor Interface driver"
-	depends on VIDEO_DEV && SOC_CAMERA && (MACH_MX27 || ARCH_MX25)
+	depends on VIDEO_DEV && SOC_CAMERA && (MACH_MX27 || (ARCH_MX25 && BROKEN))
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEO_MX2_HOSTSUPPORT
 	---help---
-- 
1.7.9.5
