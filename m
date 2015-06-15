From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 15 Jun 2015 11:13:52 +0200
Subject: [PATCH] VFIO: platform: enable ARM64 build
Message-ID: <1434359632-20278-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables building VFIO platform and derivatives on ARM64.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/platform/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/Kconfig b/drivers/vfio/platform/Kconfig
index 1df7477..bb30128 100644
--- a/drivers/vfio/platform/Kconfig
+++ b/drivers/vfio/platform/Kconfig
@@ -1,6 +1,6 @@
 config VFIO_PLATFORM
 	tristate "VFIO support for platform devices"
-	depends on VFIO && EVENTFD && ARM
+	depends on VFIO && EVENTFD && (ARM || ARM64)
 	select VFIO_VIRQFD
 	help
 	  Support for platform devices with VFIO. This is required to make
-- 
1.9.1
