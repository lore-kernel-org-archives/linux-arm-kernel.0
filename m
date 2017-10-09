From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Mon, 9 Oct 2017 20:52:32 +0200
Subject: [PATCH 2/3] firmware: arm_scpi: remove struct sensor_capabilities
In-Reply-To: <8afb173f-1480-baf8-e15b-5c01ed033671@gmail.com>
References: <8afb173f-1480-baf8-e15b-5c01ed033671@gmail.com>
Message-ID: <e48fd2ba-93b6-8c28-55e2-d3d2f95a5987@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more single-element struct was left, remove it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index dfb373c8..579941d5 100644
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
@@ -738,13 +734,13 @@ static int scpi_dvfs_add_opps_to_device(struct device *dev)
 
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
2.14.2
