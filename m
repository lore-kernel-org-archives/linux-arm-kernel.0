From: khilman@ti.com (Kevin Hilman)
Date: Mon,  1 Aug 2011 18:14:52 -0700
Subject: [PATCH] ARM: platform_device: pdev_archdata: add omap_device pointer
Message-ID: <1312247692-13727-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add omap_device pointer to the ARM-specific arch data in the
platform_device.  This will be used to attach OMAP-specific
device-data to the platform device with device lifetime.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies to v3.0

 arch/arm/include/asm/device.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 9f390ce..b5c9f5b 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -12,7 +12,12 @@ struct dev_archdata {
 #endif
 };
 
+struct omap_device;
+
 struct pdev_archdata {
+#ifdef CONFIG_ARCH_OMAP
+	struct omap_device *od;
+#endif
 };
 
 #endif
-- 
1.7.6
