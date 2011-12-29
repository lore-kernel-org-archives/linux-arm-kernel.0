From: dron0gus@gmail.com (Gusakov Andrey)
Date: Thu, 29 Dec 2011 17:07:16 +0400
Subject: [PATCH] S3C: increase hwmon channels to 10
In-Reply-To: <1325164036-15638-1-git-send-email-dron0gus@gmail.com>
References: <1325164036-15638-1-git-send-email-dron0gus@gmail.com>
Message-ID: <1325164036-15638-3-git-send-email-dron0gus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C2416/2443 have 10-ch ADC. So increase number of hwmon's channels
to 10.

Signed-off-by: Gusakov Andrey <dron0gus@gmail.com>
---
 arch/arm/plat-samsung/include/plat/hwmon.h |    2 +-
 drivers/hwmon/s3c-hwmon.c                  |    8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/hwmon.h b/arch/arm/plat-samsung/include/plat/hwmon.h
index c167e44..91d8a13 100644
--- a/arch/arm/plat-samsung/include/plat/hwmon.h
+++ b/arch/arm/plat-samsung/include/plat/hwmon.h
@@ -34,7 +34,7 @@ struct s3c_hwmon_chcfg {
  * @in: One configuration for each possible channel used.
  */
 struct s3c_hwmon_pdata {
-	struct s3c_hwmon_chcfg	*in[8];
+	struct s3c_hwmon_chcfg	*in[10];
 };
 
 /**
diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index f6c26d1..894110d 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -55,7 +55,7 @@ struct s3c_hwmon {
 	struct s3c_adc_client	*client;
 	struct device		*hwmon_dev;
 
-	struct s3c_hwmon_attr	attrs[8];
+	struct s3c_hwmon_attr	attrs[10];
 };
 
 /**
@@ -119,8 +119,10 @@ DEF_ADC_ATTR(4);
 DEF_ADC_ATTR(5);
 DEF_ADC_ATTR(6);
 DEF_ADC_ATTR(7);
+DEF_ADC_ATTR(8);
+DEF_ADC_ATTR(9);
 
-static struct attribute *s3c_hwmon_attrs[9] = {
+static struct attribute *s3c_hwmon_attrs[11] = {
 	&sensor_dev_attr_adc0_raw.dev_attr.attr,
 	&sensor_dev_attr_adc1_raw.dev_attr.attr,
 	&sensor_dev_attr_adc2_raw.dev_attr.attr,
@@ -129,6 +131,8 @@ static struct attribute *s3c_hwmon_attrs[9] = {
 	&sensor_dev_attr_adc5_raw.dev_attr.attr,
 	&sensor_dev_attr_adc6_raw.dev_attr.attr,
 	&sensor_dev_attr_adc7_raw.dev_attr.attr,
+	&sensor_dev_attr_adc8_raw.dev_attr.attr,
+	&sensor_dev_attr_adc9_raw.dev_attr.attr,
 	NULL,
 };
 
-- 
1.7.0.4
