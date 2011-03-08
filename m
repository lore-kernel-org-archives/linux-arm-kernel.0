From: andy@warmcat.com (Andy Green)
Date: Tue, 08 Mar 2011 11:09:04 +0000
Subject: [PATCH 2 14/18] I2C: OMAP1/OMAP2+: create omap I2C functionality
	flags for each cpu_... test
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Message-ID: <20110308110904.23531.66727.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These represent the 8 kinds of implementation functionality
that up until now were inferred by the 16 remaining cpu_...()
tests in the omap i2c driver.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 include/linux/i2c-omap.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 776c8e1..98ae49b 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -15,6 +15,21 @@
 #define OMAP_I2C_IP_VERSION_1 1
 #define OMAP_I2C_IP_VERSION_2 2
 
+/* struct omap_i2c_bus_platform_data .flags meanings */
+
+#define OMAP_I2C_FLAG_NO_FIFO 1
+#define OMAP_I2C_FLAG_SIMPLE_CLOCK 2
+#define OMAP_I2C_FLAG_16BIT_DATA_REG 4
+#define OMAP_I2C_FLAG_RESET_REGS_POSTIDLE 8
+#define OMAP_I2C_FLAG_APPLY_ERRATA_I207 0x10
+#define OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK 0x20
+#define OMAP_I2C_FLAG_FORCE_19200_INT_CLK 0x40
+/* how the CPU address bus must be translated for I2C unit access */
+#define OMAP_I2C_FLAG_BUS_SHIFT_NONE 0
+#define OMAP_I2C_FLAG_BUS_SHIFT_1 0x80
+#define OMAP_I2C_FLAG_BUS_SHIFT_2 0x100
+#define OMAP_I2C_FLAG_BUS_SHIFT__SHIFT 7
+
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
 	u32		rev;
