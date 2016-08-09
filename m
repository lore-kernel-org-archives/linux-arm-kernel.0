From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  9 Aug 2016 12:29:17 +0200
Subject: [RFC PATCH v3 3/8] scpi: Add vendor_send_message to enable access to
 vendor commands
In-Reply-To: <1470738562-20026-1-git-send-email-narmstrong@baylibre.com>
References: <1470738562-20026-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1470738562-20026-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds an optional vendor_send_message to the scpi to enable sending
vendor platform specific commands to the SCP firmware.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/linux/scpi_protocol.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index 8e21e3a..dd5d81d 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -58,6 +58,8 @@ struct scpi_sensor_info {
  *	OPP is an index to the list return by @dvfs_get_info
  * @dvfs_get_info: returns the DVFS capabilities of the given power
  *	domain. It includes the OPP list and the latency information
+ * @vendor_send_message: vendor specific message sending, arg can specify
+ *	a scpi implementation specific argument
  */
 struct scpi_ops {
 	u32 (*get_version)(void);
@@ -72,6 +74,9 @@ struct scpi_ops {
 	int (*sensor_get_value)(u16, u64 *);
 	int (*device_get_power_state)(u16);
 	int (*device_set_power_state)(u16, u8);
+	int (*vendor_send_message)(u8 cmd, unsigned long arg,
+				   void *tx_buf, unsigned int tx_len,
+				   void *rx_buf, unsigned int rx_len);
 };
 
 #if IS_REACHABLE(CONFIG_SCPI_FW)
-- 
2.7.0
