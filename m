From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:59 +0100
Subject: [PATCH v1 14/24] zynq: Add GEM0, GEM1 configs support
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <bd249a57750312673d4046d94a63130617e9bcde.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Zynq ethernet controller support two GEM's like
CONFIG_ZYNQ_GEM0 and CONFIG_ZYNQ_GEM1 enabled
both so-that the respective board will define
these macros based on their usage.

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index 6632223..2f8f4ab 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -42,10 +42,16 @@
 #endif

 /* Ethernet driver */
-#define CONFIG_NET_MULTI
-#define CONFIG_ZYNQ_GEM
 #define CONFIG_ZYNQ_GEM0
 #define CONFIG_ZYNQ_GEM_PHY_ADDR0	7
+#if defined(CONFIG_ZYNQ_GEM0) || defined(CONFIG_ZYNQ_GEM1)
+# define CONFIG_NET_MULTI
+# define CONFIG_ZYNQ_GEM
+# define CONFIG_MII
+# define CONFIG_SYS_FAULT_ECHO_LINK_DOWN
+# define CONFIG_PHYLIB
+# define CONFIG_PHY_MARVELL
+#endif

 #define CONFIG_ZYNQ_SPI
 /* SPI */
@@ -89,12 +95,6 @@
 #define CONFIG_BOOTP_HOSTNAME
 #define CONFIG_BOOTP_MAY_FAIL

-/* MII and Phylib */
-#define CONFIG_MII
-#define CONFIG_SYS_FAULT_ECHO_LINK_DOWN
-#define CONFIG_PHYLIB
-#define CONFIG_PHY_MARVELL
-
 /* Environment */
 #define CONFIG_ENV_SIZE		0x10000 /* Env. sector size */
 #define CONFIG_ENV_IS_NOWHERE
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/ef2c80e3/attachment.sig>
