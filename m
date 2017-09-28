From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Sep 2017 14:11:43 +0100
Subject: [PATCH v3 19/22] hwmon: (core) Add hwmon_max to hwmon_sensor_types
 enumeration
In-Reply-To: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1506604306-20739-20-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's useful to know the maximum types of sensor supported by hwmon
framework. It can be used to allocate some data structures when sorting
the monitors based on their type.

This will be used by scmi hwmon support.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon at vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/hwmon.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index ceb751987c40..e5fd2707b6df 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -29,6 +29,7 @@ enum hwmon_sensor_types {
 	hwmon_humidity,
 	hwmon_fan,
 	hwmon_pwm,
+	hwmon_max,
 };
 
 enum hwmon_chip_attributes {
-- 
2.7.4
