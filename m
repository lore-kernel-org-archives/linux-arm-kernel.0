From: davidsin@ti.com (David Sin)
Date: Fri, 23 Jul 2010 18:28:14 -0500
Subject: [RFC 8/8] TILER-DMM: Linking TILER driver into the Linux kernel build
In-Reply-To: <1279927694-26138-8-git-send-email-davidsin@ti.com>
References: <1279927694-26138-1-git-send-email-davidsin@ti.com>
	<1279927694-26138-2-git-send-email-davidsin@ti.com>
	<1279927694-26138-3-git-send-email-davidsin@ti.com>
	<1279927694-26138-4-git-send-email-davidsin@ti.com>
	<1279927694-26138-5-git-send-email-davidsin@ti.com>
	<1279927694-26138-6-git-send-email-davidsin@ti.com>
	<1279927694-26138-7-git-send-email-davidsin@ti.com>
	<1279927694-26138-8-git-send-email-davidsin@ti.com>
Message-ID: <1279927694-26138-9-git-send-email-davidsin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lajos Molnar <molnar@ti.com>

This patch links the TILER driver into the Linux kernel build
and config system.

Signed-off-by: Lajos Molnar <molnar@ti.com>
Signed-off-by: David Sin <davidsin@ti.com>
---
 drivers/media/Kconfig  |    6 ++++++
 drivers/media/Makefile |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index a28541b..96ebc1d 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -98,6 +98,12 @@ config VIDEO_MEDIA
 
 comment "Multimedia drivers"
 
+#
+# TI TILER driver support
+#
+
+source "drivers/media/video/tiler/Kconfig"
+
 source "drivers/media/common/Kconfig"
 source "drivers/media/IR/Kconfig"
 
diff --git a/drivers/media/Makefile b/drivers/media/Makefile
index 499b081..922d71c 100644
--- a/drivers/media/Makefile
+++ b/drivers/media/Makefile
@@ -4,5 +4,7 @@
 
 obj-y += common/ IR/ video/
 
+obj-${CONFIG_TI_TILER} += video/tiler/
+
 obj-$(CONFIG_VIDEO_DEV) += radio/
 obj-$(CONFIG_DVB_CORE)  += dvb/
-- 
1.6.3.3
