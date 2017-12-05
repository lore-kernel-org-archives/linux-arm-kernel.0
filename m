From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 5 Dec 2017 23:17:13 +0100
Subject: [PATCH 10/12] firmware: arm_scpi: remove struct sensor_capabilities
In-Reply-To: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
References: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
Message-ID: <15722eb4-836c-eb30-fdff-8389ff8e6703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more single-element struct was left, remove it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index b653ada4..5695b1f4 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -331,10 +331,6 @@ struct dvfs_set {
 	u8 index;
 } __packed;
 
-struct sensor_capabilities {
-	__le16 sensors;
-} __packed;
-
 struct _scpi_sensor_info {
 	__le16 sensor_id;
 	u8 class;
@@ -730,13 +726,13 @@ static int scpi_dvfs_add_opps_to_device(struct device *dev)
 
 static int scpi_sensor_get_capability(u16 *sensors)
 {
-	struct sensor_capabilities cap_buf;
+	__le16 cap;
 	int ret;
 
-	ret = scpi_send_message(CMD_SENSOR_CAPABILITIES, NULL, 0, &cap_buf,
-				sizeof(cap_buf));
+	ret = scpi_send_message(CMD_SENSOR_CAPABILITIES, NULL, 0, &cap,
+				sizeof(cap));
 	if (!ret)
-		*sensors = le16_to_cpu(cap_buf.sensors);
+		*sensors = le16_to_cpu(cap);
 
 	return ret;
 }
-- 
2.15.1
