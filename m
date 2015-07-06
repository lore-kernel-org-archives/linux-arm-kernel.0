From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  6 Jul 2015 14:11:28 +0200
Subject: [RFC v2 2/6] VFIO: platform: select IRQ_BYPASS_MANAGER
In-Reply-To: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
References: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1436184692-20927-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select IRQ_BYPASS_MANAGER when CONFIG_VFIO_PLATFORM is set

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/platform/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/platform/Kconfig b/drivers/vfio/platform/Kconfig
index bb30128..c2f3dce 100644
--- a/drivers/vfio/platform/Kconfig
+++ b/drivers/vfio/platform/Kconfig
@@ -2,6 +2,7 @@ config VFIO_PLATFORM
 	tristate "VFIO support for platform devices"
 	depends on VFIO && EVENTFD && (ARM || ARM64)
 	select VFIO_VIRQFD
+	select IRQ_BYPASS_MANAGER
 	help
 	  Support for platform devices with VFIO. This is required to make
 	  use of platform devices present on the system using the VFIO
-- 
1.9.1
