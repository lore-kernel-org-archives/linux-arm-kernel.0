From: andy@warmcat.com (Andy Green)
Date: Tue, 08 Mar 2011 11:08:05 +0000
Subject: [PATCH 2 06/18] I2C: OMAP1: set IP revision in platform data
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Message-ID: <20110308110804.23531.45336.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All OMAP1 are using "IP revision 1" in terms of register
layout.  We set this information in omap1_i2c_add_bus() so
we don't have to use cpu_is_xxx() any more in the omap i2c
driver.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
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
 
