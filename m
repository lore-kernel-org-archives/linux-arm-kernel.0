From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  6 Jun 2016 16:36:05 +0100
Subject: [PATCH 2/3] firmware: arm_scpi: mark scpi_get_sensor_value as static
In-Reply-To: <1465227366-12192-1-git-send-email-sudeep.holla@arm.com>
References: <1465227366-12192-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1465227366-12192-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

scpi_get_sensor_value like other scpi operations needs to be static.
This patch marks it as static to be consistent with others.

Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 279fb84f69e1..51c6db0774cc 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -522,7 +522,7 @@ static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
 	return ret;
 }

-int scpi_sensor_get_value(u16 sensor, u64 *val)
+static int scpi_sensor_get_value(u16 sensor, u64 *val)
 {
 	__le16 id = cpu_to_le16(sensor);
 	struct sensor_value buf;
--
2.7.4
