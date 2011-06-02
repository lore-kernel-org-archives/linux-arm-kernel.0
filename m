From: khilman@ti.com (Kevin Hilman)
Date: Wed,  1 Jun 2011 17:19:32 -0700
Subject: [PATCH v4 06/18] I2C: OMAP1: set IP revision in platform data
In-Reply-To: <1306973984-15165-1-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Message-ID: <1306973984-15165-7-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Green <andy@warmcat.com>

All OMAP1 are using "IP revision 1" in terms of register
layout.  We set this information in omap1_i2c_add_bus() so
we don't have to use cpu_is_xxx() any more in the omap i2c
driver.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/i2c.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 3341ca4..a938df0 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -108,6 +108,9 @@ static inline int omap1_i2c_add_bus(int bus_id)
 	res[1].start = INT_I2C;
 	pdata = &i2c_pdata[bus_id - 1];
 
+	/* all OMAP1 have IP version 1 register set */
+	pdata->rev = OMAP_I2C_IP_VERSION_1;
+
 	return platform_device_register(pdev);
 }
 
-- 
1.7.4
