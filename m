From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:11:04 +0100
Subject: [PATCH v1 19/24] zynq-common: Define flash env. partition
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <9c00c6840757ad351a96ecb1c1b1bb0132c2160b.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Last 128Kb sector of 1Mb flash is defined as u-boot
environment partition.

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index a6caf0c..2e82073 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -110,7 +110,17 @@
 #define CONFIG_ENV_SIZE			(128 << 10)

 /* Environment */
-#define CONFIG_ENV_IS_NOWHERE
+#ifndef CONFIG_ENV_IS_NOWHERE
+# ifndef CONFIG_SYS_NO_FLASH
+#  define CONFIG_ENV_IS_IN_FLASH
+# elif defined(CONFIG_SYS_NO_FLASH)
+#  define CONFIG_ENV_IS_NOWHERE
+# endif
+
+# define CONFIG_ENV_SECT_SIZE		CONFIG_ENV_SIZE
+# define CONFIG_ENV_OFFSET		0xE0000
+# define CONFIG_CMD_SAVEENV
+#endif

 /* Default environment */
 #define CONFIG_EXTRA_ENV_SETTINGS	\
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/11ffe7ad/attachment-0001.sig>
