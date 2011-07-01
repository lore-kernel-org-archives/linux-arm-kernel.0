From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 01 Jul 2011 17:03:12 +0530
Subject: [PATCH 2/2] ARM: Samsung: Cleanup I2C code in plat-samsung
In-Reply-To: <1309519992-3026-1-git-send-email-ch.naveen@samsung.com>
References: <1309519992-3026-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1309519992-3026-3-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removes the duplication of default info structure in
dev-i2c[0 ~ 7].c files

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 arch/arm/plat-samsung/dev-i2c0.c         |    4 ++--
 arch/arm/plat-samsung/dev-i2c1.c         |   14 ++++----------
 arch/arm/plat-samsung/dev-i2c2.c         |   14 ++++----------
 arch/arm/plat-samsung/dev-i2c3.c         |   14 ++++----------
 arch/arm/plat-samsung/dev-i2c4.c         |   14 ++++----------
 arch/arm/plat-samsung/dev-i2c5.c         |   14 ++++----------
 arch/arm/plat-samsung/dev-i2c6.c         |   14 ++++----------
 arch/arm/plat-samsung/dev-i2c7.c         |   14 ++++----------
 arch/arm/plat-samsung/include/plat/iic.h |    2 ++
 9 files changed, 32 insertions(+), 72 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-i2c0.c b/arch/arm/plat-samsung/dev-i2c0.c
index b3c7435..09a6633e 100644
--- a/arch/arm/plat-samsung/dev-i2c0.c
+++ b/arch/arm/plat-samsung/dev-i2c0.c
@@ -48,7 +48,7 @@ struct platform_device s3c_device_i2c0 = {
 	.resource	  = s3c_i2c_resource,
 };
 
-static struct s3c2410_platform_i2c default_i2c_data0 __initdata = {
+struct s3c2410_platform_i2c default_i2c_data __initdata = {
 	.flags		= 0,
 	.slave_addr	= 0x10,
 	.frequency	= 100*1000,
@@ -60,7 +60,7 @@ void __init s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *pd)
 	struct s3c2410_platform_i2c *npd;
 
 	if (!pd)
-		pd = &default_i2c_data0;
+		pd = &default_i2c_data;
 
 	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
 			&s3c_device_i2c0);
diff --git a/arch/arm/plat-samsung/dev-i2c1.c b/arch/arm/plat-samsung/dev-i2c1.c
index 93dbb97..d48d163 100644
--- a/arch/arm/plat-samsung/dev-i2c1.c
+++ b/arch/arm/plat-samsung/dev-i2c1.c
@@ -44,20 +44,14 @@ struct platform_device s3c_device_i2c1 = {
 	.resource	  = s3c_i2c_resource,
 };
 
-static struct s3c2410_platform_i2c default_i2c_data1 __initdata = {
-	.flags		= 0,
-	.bus_num	= 1,
-	.slave_addr	= 0x10,
-	.frequency	= 100*1000,
-	.sda_delay	= 100,
-};
-
 void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)
 {
 	struct s3c2410_platform_i2c *npd;
 
-	if (!pd)
-		pd = &default_i2c_data1;
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 1;
+	}
 
 	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
 			&s3c_device_i2c1);
diff --git a/arch/arm/plat-samsung/dev-i2c2.c b/arch/arm/plat-samsung/dev-i2c2.c
index fce3b95..9620a51 100644
--- a/arch/arm/plat-samsung/dev-i2c2.c
+++ b/arch/arm/plat-samsung/dev-i2c2.c
@@ -45,20 +45,14 @@ struct platform_device s3c_device_i2c2 = {
 	.resource	  = s3c_i2c_resource,
 };
 
-static struct s3c2410_platform_i2c default_i2c_data2 __initdata = {
-	.flags		= 0,
-	.bus_num	= 2,
-	.slave_addr	= 0x10,
-	.frequency	= 100*1000,
-	.sda_delay	= 100,
-};
-
 void __init s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *pd)
 {
 	struct s3c2410_platform_i2c *npd;
 
-	if (!pd)
-		pd = &default_i2c_data2;
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 2;
+	}
 
 	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
 			&s3c_device_i2c2);
diff --git a/arch/arm/plat-samsung/dev-i2c3.c b/arch/arm/plat-samsung/dev-i2c3.c
index 46f87ad..e4a4780 100644
--- a/arch/arm/plat-samsung/dev-i2c3.c
+++ b/arch/arm/plat-samsung/dev-i2c3.c
@@ -43,20 +43,14 @@ struct platform_device s3c_device_i2c3 = {
 	.resource	= s3c_i2c_resource,
 };
 
-static struct s3c2410_platform_i2c default_i2c_data3 __initdata = {
-	.flags		= 0,
-	.bus_num	= 3,
-	.slave_addr	= 0x10,
-	.frequency	= 100*1000,
-	.sda_delay	= 100,
-};
-
 void __init s3c_i2c3_set_platdata(struct s3c2410_platform_i2c *pd)
 {
 	struct s3c2410_platform_i2c *npd;
 
-	if (!pd)
-		pd = &default_i2c_data3;
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 3;
+	}
 
 	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
 			&s3c_device_i2c3);
diff --git a/arch/arm/plat-samsung/dev-i2c4.c b/arch/arm/plat-samsung/dev-i2c4.c
index 02be589..7402479 100644
--- a/arch/arm/plat-samsung/dev-i2c4.c
+++ b/arch/arm/plat-samsung/dev-i2c4.c
@@ -43,20 +43,14 @@ struct platform_device s3c_device_i2c4 = {
 	.resource	= s3c_i2c_resource,
 };
 
-static struct s3c2410_platform_i2c default_i2c_data4 __initdata = {
-	.flags		= 0,
-	.bus_num	= 4,
-	.slave_addr	= 0x10,
-	.frequency	= 100*1000,
-	.sda_delay	= 100,
-};
-
 void __init s3c_i2c4_set_platdata(struct s3c2410_platform_i2c *pd)
 {
 	struct s3c2410_platform_i2c *npd;
 
-	if (!pd)
-		pd = &default_i2c_data4;
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 4;
+	}
 
 	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
 			&s3c_device_i2c4);
diff --git a/arch/arm/plat-samsung/dev-i2c5.c b/arch/arm/plat-samsung/dev-i2c5.c
index 3b84bed..7fa4a40 100644
--- a/arch/arm/plat-samsung/dev-i2c5.c
+++ b/arch/arm/plat-samsung/dev-i2c5.c
@@ -43,20 +43,14 @@ struct platform_device s3c_device_i2c5 = {
 	.resource	= s3c_i2c_resource,
 };
 
-static struct s3c2410_platform_i2c default_i2c_data5 __initdata = {
-	.flags		= 0,
-	.bus_num	= 5,
-	.slave_addr	= 0x10,
-	.frequency	= 100*1000,
-	.sda_delay	= 100,
-};
-
 void __init s3c_i2c5_set_platdata(struct s3c2410_platform_i2c *pd)
 {
 	struct s3c2410_platform_i2c *npd;
 
-	if (!pd)
-		pd = &default_i2c_data5;
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 5;
+	}
 
 	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
 			&s3c_device_i2c5);
diff --git a/arch/arm/plat-samsung/dev-i2c6.c b/arch/arm/plat-samsung/dev-i2c6.c
index c57c195..78e6b31 100644
--- a/arch/arm/plat-samsung/dev-i2c6.c
+++ b/arch/arm/plat-samsung/dev-i2c6.c
@@ -43,20 +43,14 @@ struct platform_device s3c_device_i2c6 = {
 	.resource	= s3c_i2c_resource,
 };
 
-static struct s3c2410_platform_i2c default_i2c_data6 __initdata = {
-	.flags		= 0,
-	.bus_num	= 6,
-	.slave_addr	= 0x10,
-	.frequency	= 100*1000,
-	.sda_delay	= 100,
-};
-
 void __init s3c_i2c6_set_platdata(struct s3c2410_platform_i2c *pd)
 {
 	struct s3c2410_platform_i2c *npd;
 
-	if (!pd)
-		pd = &default_i2c_data6;
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 6;
+	}
 
 	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
 			&s3c_device_i2c6);
diff --git a/arch/arm/plat-samsung/dev-i2c7.c b/arch/arm/plat-samsung/dev-i2c7.c
index 2cb9682..2b4859f 100644
--- a/arch/arm/plat-samsung/dev-i2c7.c
+++ b/arch/arm/plat-samsung/dev-i2c7.c
@@ -43,20 +43,14 @@ struct platform_device s3c_device_i2c7 = {
 	.resource	= s3c_i2c_resource,
 };
 
-static struct s3c2410_platform_i2c default_i2c_data7 __initdata = {
-	.flags		= 0,
-	.bus_num	= 7,
-	.slave_addr	= 0x10,
-	.frequency	= 100*1000,
-	.sda_delay	= 100,
-};
-
 void __init s3c_i2c7_set_platdata(struct s3c2410_platform_i2c *pd)
 {
 	struct s3c2410_platform_i2c *npd;
 
-	if (!pd)
-		pd = &default_i2c_data7;
+	if (!pd) {
+		pd = &default_i2c_data;
+		pd->bus_num = 7;
+	}
 
 	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
 			&s3c_device_i2c7);
diff --git a/arch/arm/plat-samsung/include/plat/iic.h b/arch/arm/plat-samsung/include/plat/iic.h
index 1543da8..56b0059 100644
--- a/arch/arm/plat-samsung/include/plat/iic.h
+++ b/arch/arm/plat-samsung/include/plat/iic.h
@@ -71,4 +71,6 @@ extern void s3c_i2c5_cfg_gpio(struct platform_device *dev);
 extern void s3c_i2c6_cfg_gpio(struct platform_device *dev);
 extern void s3c_i2c7_cfg_gpio(struct platform_device *dev);
 
+extern struct s3c2410_platform_i2c default_i2c_data;
+
 #endif /* __ASM_ARCH_IIC_H */
-- 
1.7.2.3
