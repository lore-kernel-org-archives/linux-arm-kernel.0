From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Sep 2010 18:51:05 -0700
Subject: [PATCH 08/11] omap: i2c: Avoid compilation error in case the header
	is included multiple times
In-Reply-To: <20100924014938.10325.35279.stgit@baageli.muru.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
Message-ID: <20100924015105.10325.65902.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Subramaniam C.A <subramaniam.ca@ti.com>

Added defines to avoid compilation error.

Signed-off-by: Subramaniam C.A <subramaniam.ca@ti.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/i2c.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 87f6bf2..36a0bef 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -18,6 +18,8 @@
  * 02110-1301 USA
  *
  */
+#ifndef __ASM__ARCH_OMAP_I2C_H
+#define __ASM__ARCH_OMAP_I2C_H
 
 #include <linux/i2c.h>
 
@@ -36,3 +38,5 @@ static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
 
 void __init omap1_i2c_mux_pins(int bus_id);
 void __init omap2_i2c_mux_pins(int bus_id);
+
+#endif /* __ASM__ARCH_OMAP_I2C_H */
