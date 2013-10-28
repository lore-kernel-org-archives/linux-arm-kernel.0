From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 00:46:57 +0100
Subject: [PATCH 09/19] mmc: sh_mmcif: Enable the driver on all ARM platforms
In-Reply-To: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383004027-25036-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI and increase build testing coverage.

Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 51957d4..1f3a0c1 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -588,7 +588,7 @@ config MMC_DW_PCI
 
 config MMC_SH_MMCIF
 	tristate "SuperH Internal MMCIF support"
-	depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
+	depends on MMC_BLOCK && (SUPERH || ARM)
 	help
 	  This selects the MMC Host Interface controller (MMCIF).
 
-- 
1.8.1.5
