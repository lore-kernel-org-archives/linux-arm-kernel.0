From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:54 +0100
Subject: [PATCH v1 09/24] zynq: Cleanup on memory configs
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <cf487c10048d7c7216449b8324aef151d1619205.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Cleanup on memory configuration options:
- Add comment
- Re-order configs

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index e34024d..8be52df 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -13,14 +13,6 @@
 /* CPU clock */
 #define CONFIG_CPU_FREQ_HZ	800000000

-/* Ram */
-#define CONFIG_NR_DRAM_BANKS		1
-#define CONFIG_SYS_TEXT_BASE		0
-#define CONFIG_SYS_SDRAM_BASE		0
-#define CONFIG_SYS_SDRAM_SIZE		0x40000000
-#define CONFIG_SYS_MEMTEST_START	CONFIG_SYS_SDRAM_BASE
-#define CONFIG_SYS_MEMTEST_END		(CONFIG_SYS_SDRAM_BASE + 0x1000)
-
 /* The following table includes the supported baudrates */
 #define CONFIG_SYS_BAUDRATE_TABLE  \
 	{300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200, 230400}
@@ -105,11 +97,6 @@
 #define CONFIG_SYS_NO_FLASH

 #define CONFIG_SYS_MALLOC_LEN		0x400000
-#define CONFIG_SYS_INIT_RAM_ADDR	CONFIG_SYS_SDRAM_BASE
-#define CONFIG_SYS_INIT_RAM_SIZE	CONFIG_SYS_MALLOC_LEN
-#define CONFIG_SYS_INIT_SP_ADDR		(CONFIG_SYS_INIT_RAM_ADDR + \
-						CONFIG_SYS_INIT_RAM_SIZE - \
-						GENERATED_GBL_DATA_SIZE)

 /* Miscellaneous configurable options */
 #define CONFIG_SYS_PROMPT		"zynq-uboot> "
@@ -125,7 +112,21 @@

 #define CONFIG_SYS_LOAD_ADDR	0

+/* Physical Memory map */
+#define CONFIG_SYS_TEXT_BASE		0

+#define CONFIG_NR_DRAM_BANKS		1
+#define CONFIG_SYS_SDRAM_BASE		0
+#define CONFIG_SYS_SDRAM_SIZE		0x40000000
+
+#define CONFIG_SYS_MEMTEST_START	CONFIG_SYS_SDRAM_BASE
+#define CONFIG_SYS_MEMTEST_END		(CONFIG_SYS_SDRAM_BASE + 0x1000)
+
+#define CONFIG_SYS_INIT_RAM_ADDR	CONFIG_SYS_SDRAM_BASE
+#define CONFIG_SYS_INIT_RAM_SIZE	CONFIG_SYS_MALLOC_LEN
+#define CONFIG_SYS_INIT_SP_ADDR		(CONFIG_SYS_INIT_RAM_ADDR + \
+					CONFIG_SYS_INIT_RAM_SIZE - \
+					GENERATED_GBL_DATA_SIZE)
 /* OF */
 #define CONFIG_FIT
 #define CONFIG_FIT_VERBOSE	1 /* enable fit_format_{error,warning}() */
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/b64bc061/attachment.sig>
