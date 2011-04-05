From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue,  5 Apr 2011 17:38:05 -0400
Subject: [PATCH 2/6] i2c-davinci: convert davinci_i2c_platform_data to
	kerneldoc
In-Reply-To: <cover.1302031487.git.bengardiner@nanometrics.ca>
References: <cover.1302031487.git.bengardiner@nanometrics.ca>
Message-ID: <0710b48a8514dface179b54c615b7cc0bba20d42.1302031487.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci_i2c_platform_data struct is mach-specific but still deserves
to be documented using kernel doc.

Signed-off-by: Ben Gardiner<bengardiner@nanometrics.ca>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>

---
 arch/arm/mach-davinci/include/mach/i2c.h |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/i2c.h b/arch/arm/mach-davinci/include/mach/i2c.h
index 2312d19..ab07a44 100644
--- a/arch/arm/mach-davinci/include/mach/i2c.h
+++ b/arch/arm/mach-davinci/include/mach/i2c.h
@@ -12,12 +12,19 @@
 #ifndef __ASM_ARCH_I2C_H
 #define __ASM_ARCH_I2C_H
 
-/* All frequencies are expressed in kHz */
+/**
+ * davinci_i2c_platform_data - Platform data for I2C master device on DaVinci
+ *
+ * @bus_freq:	standard bus frequency (kHz)
+ * @bus_delay:	post-transaction delay (usec)
+ * @sda_pin:	GPIO pin ID to use for SDA
+ * @scl_pin:	GPIO pin ID to use for SCL
+ */
 struct davinci_i2c_platform_data {
-	unsigned int	bus_freq;	/* standard bus frequency (kHz) */
-	unsigned int	bus_delay;	/* post-transaction delay (usec) */
-	unsigned int    sda_pin;        /* GPIO pin ID to use for SDA */
-	unsigned int    scl_pin;        /* GPIO pin ID to use for SCL */
+	unsigned int	bus_freq;
+	unsigned int	bus_delay;
+	unsigned int	sda_pin;
+	unsigned int	scl_pin;
 };
 
 /* for board setup code */
-- 
1.7.1
