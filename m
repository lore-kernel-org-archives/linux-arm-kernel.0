From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:11:02 +0100
Subject: [PATCH v1 17/24] zynq-common: Define default environment
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <7c5314edd479185e912dacf89ce9540c425b42d0.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Defined default env. for autoboot FIT image from
respective boot devices.

Default settings:
fit_image=fit.itb
load_addr=0x2000000
fit_size=0x800000
flash_off=0x100000
nor_flash_off=0xE2100000

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index 2ea5d3f..5a33e15 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -109,7 +109,28 @@
 /* Environment */
 #define CONFIG_ENV_SIZE		0x10000 /* Env. sector size */
 #define CONFIG_ENV_IS_NOWHERE
-#define CONFIG_SYS_LOAD_ADDR	0
+
+/* Default environment */
+#define CONFIG_EXTRA_ENV_SETTINGS	\
+	"fit_image=fit.itb\0"		\
+	"load_addr=0x2000000\0"		\
+	"fit_size=0x800000\0"		\
+	"flash_off=0x100000\0"		\
+	"nor_flash_off=0xE2100000\0"	\
+	"fdt_high=0x20000000\0"		\
+	"initrd_high=0x20000000\0"	\
+	"norboot=echo Copying FIT from NOR flash to RAM... && " \
+		"cp.b ${nor_flash_off} ${load_addr} ${fit_size} && " \
+		"bootm ${load_addr}\0" \
+	"sdboot=echo Copying FIT from SD to RAM... && " \
+		"fatload mmc 0 ${load_addr} ${fit_image} && " \
+		"bootm ${load_addr}\0" \
+	"jtagboot=echo TFTPing FIT to RAM... && " \
+		"tftp ${load_addr} ${fit_image} && " \
+		"bootm ${load_addr}\0"
+#define CONFIG_BOOTCOMMAND		"run $modeboot"
+#define CONFIG_BOOTDELAY		3 /* -1 to Disable autoboot */
+#define CONFIG_SYS_LOAD_ADDR		0 /* default? */

 /* Miscellaneous configurable options */
 #define CONFIG_SYS_PROMPT		"zynq-uboot> "
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/89206355/attachment-0001.sig>
