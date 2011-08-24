From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 08:41:12 +0200
Subject: [PATCH 5/5] media i.MX1 camera: remove dependency on ARCH_MX1
In-Reply-To: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
References: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1314168072-13822-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARCH_MX1 macro is scheduled for removal. Instead,
depend on ARCH_MXC. The Kconfig text makes it clear
on which SoC rhis driver runs on.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/media/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index f574dc0..bc5df0e 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -883,7 +883,7 @@ config MX1_VIDEO
 
 config VIDEO_MX1
 	tristate "i.MX1/i.MXL CMOS Sensor Interface driver"
-	depends on VIDEO_DEV && ARCH_MX1 && SOC_CAMERA
+	depends on VIDEO_DEV && ARCH_MXC && SOC_CAMERA
 	select FIQ
 	select VIDEOBUF_DMA_CONTIG
 	select MX1_VIDEO
-- 
1.7.5.4
