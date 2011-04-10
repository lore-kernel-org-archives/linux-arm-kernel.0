From: cavokz@gmail.com (Domenico Andreoli)
Date: Sun, 10 Apr 2011 17:33:12 +0200
Subject: [patch 1/2] Add dt_compat field to struct s3c_gpio_chip
References: <20110410152735.338798127@gmail.com>
Message-ID: <20110410153312.GB27088@dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <cavokz@gmail.com>

This new field allows easy creation of GPIO chips in base of struct arrays.

Signed-off-by: Domenico Andreoli <cavokz@gmail.com>

---
 arch/arm/plat-samsung/include/plat/gpio-core.h |    3 +++
 1 file changed, 3 insertions(+)

Index: b/arch/arm/plat-samsung/include/plat/gpio-core.h
===================================================================
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h	2011-04-07 22:43:45.000000000 +0200
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h	2011-04-10 16:00:39.000000000 +0200
@@ -71,6 +71,9 @@
 #ifdef CONFIG_PM
 	u32			pm_save[4];
 #endif
+#ifdef CONFIG_OF_GPIO
+	const char		*dt_compat;
+#endif
 };
 
 static inline struct s3c_gpio_chip *to_s3c_gpio(struct gpio_chip *gpc)
