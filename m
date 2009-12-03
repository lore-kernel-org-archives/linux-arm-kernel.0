From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 03 Dec 2009 06:49:52 -0700
Subject: [PATCH 06/10] OMAP: omap_device: use UINT_MAX for default wakeup
	latency limit
In-Reply-To: <20091203134852.17146.81997.stgit@localhost.localdomain>
References: <20091203134852.17146.81997.stgit@localhost.localdomain>
Message-ID: <20091203134951.17146.23073.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@deeprootsystems.com>

The _dev_wakeup_lat_limit field of struct omap_device is u32, so use
UINT_MAX instead of INT_MAX for the default maximum.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index bb16e62..54fe0a2 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -459,7 +459,7 @@ int omap_device_enable(struct platform_device *pdev)
 	ret = _omap_device_activate(od, IGNORE_WAKEUP_LAT);
 
 	od->dev_wakeup_lat = 0;
-	od->_dev_wakeup_lat_limit = INT_MAX;
+	od->_dev_wakeup_lat_limit = UINT_MAX;
 	od->_state = OMAP_DEVICE_STATE_ENABLED;
 
 	return ret;
