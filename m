From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 21 Aug 2017 16:36:37 +0100
Subject: [PATCH] firmware: arm_scpi: fix endianness of dev_id in struct
 dev_pstate_set
Message-ID: <1503329797-5909-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

scpi_device_{g,s}et_power_state correctly handles the conversion of
endianness for dev_id using cpu_to_le16. However dev_id is declared
as u16 in struct dev_pstate_set which is incorrect.

This patch fixes the endianness of dev_id in dev_pstate_set structure.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Arnd,

Can you pick up this fix for v4.14 directly ? I can send a pull request
if required.

Regards,
Sudeep

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 8043e51de897..ab52f1bcd277 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -357,7 +357,7 @@ struct sensor_value {
 } __packed;

 struct dev_pstate_set {
-	u16 dev_id;
+	__le16 dev_id;
 	u8 pstate;
 } __packed;

--
2.7.4
