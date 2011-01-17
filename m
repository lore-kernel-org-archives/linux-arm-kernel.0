From: balbi@ti.com (Felipe Balbi)
Date: Mon, 17 Jan 2011 06:31:14 +0200
Subject: [PATCH 1/7] arm: omap: i2c: fix compile warning
In-Reply-To: <1295238680-26738-1-git-send-email-balbi@ti.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
Message-ID: <1295238680-26738-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following compile warning:
arch/arm/plat-omap/i2c.c:120:13: warning:
'omap_pm_set_max_mpu_wakeup_lat_compat' defined but not used
arch/arm/plat-omap/i2c.c:125:38: warning: 'omap_i2c_latency'
defined but not used

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/i2c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index a4f8003..3341ca4 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -112,6 +112,7 @@ static inline int omap1_i2c_add_bus(int bus_id)
 }
 
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
 /*
  * XXX This function is a temporary compatibility wrapper - only
  * needed until the I2C driver can be converted to call
@@ -130,7 +131,6 @@ static struct omap_device_pm_latency omap_i2c_latency[] = {
 	},
 };
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
 static inline int omap2_i2c_add_bus(int bus_id)
 {
 	int l;
-- 
1.7.3.4.598.g85356
