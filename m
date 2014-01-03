From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:11:01 +0100
Subject: [PATCH v1 16/24] zynq: Add Catalyst 24WC08 EEPROM config support
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <eb4b1bd909db10078eb6e80d72ab4c757c878df0.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Adds configurations for Catalyst 24WC08 EEPROM, which
is present on the zynq boards.

Enable EEPROM support for zynq boards.

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index c90d4fd..2ea5d3f 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -89,6 +89,17 @@
 # define CONFIG_SYS_I2C_ZYNQ_SLAVE		1
 #endif

+#define CONFIG_ZYNQ_EEPROM
+/* EEPROM */
+#ifdef CONFIG_ZYNQ_EEPROM
+# define CONFIG_CMD_EEPROM
+# define CONFIG_SYS_I2C_EEPROM_ADDR_LEN		1
+# define CONFIG_SYS_I2C_EEPROM_ADDR		0x54
+# define CONFIG_SYS_EEPROM_PAGE_WRITE_BITS	4
+# define CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS	5
+# define CONFIG_SYS_EEPROM_SIZE			1024 /* Bytes */
+#endif
+
 #define CONFIG_BOOTP_SERVERIP
 #define CONFIG_BOOTP_BOOTPATH
 #define CONFIG_BOOTP_GATEWAY
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/be75112e/attachment.sig>
