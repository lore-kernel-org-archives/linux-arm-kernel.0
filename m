From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:53 +0100
Subject: [PATCH v1 08/24] zynq: Cleanup on miscellaneous configs
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <461946b66507645709df455234a1c6ec2dae4481.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Cleanup on miscellaneous configurable options:
- Rename SYS_PROMPT as "zynq-uboot"
- Add comment
- Re-order configs

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index 0492818..e34024d 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -111,19 +111,20 @@
 						CONFIG_SYS_INIT_RAM_SIZE - \
 						GENERATED_GBL_DATA_SIZE)

-#define CONFIG_SYS_PROMPT	"U-Boot> "
-#define CONFIG_SYS_CBSIZE	256 /* Console I/O Buffer Size */
-#define CONFIG_SYS_PBSIZE	(CONFIG_SYS_CBSIZE + \
+/* Miscellaneous configurable options */
+#define CONFIG_SYS_PROMPT		"zynq-uboot> "
+#define CONFIG_SYS_HUSH_PARSER
+
+#define CONFIG_CMDLINE_EDITING
+#define CONFIG_AUTO_COMPLETE
+#define CONFIG_SYS_LONGHELP
+#define CONFIG_SYS_MAXARGS		15 /* max number of command args */
+#define CONFIG_SYS_CBSIZE		256 /* Console I/O Buffer Size */
+#define CONFIG_SYS_PBSIZE		(CONFIG_SYS_CBSIZE + \
 					sizeof(CONFIG_SYS_PROMPT) + 16)

 #define CONFIG_SYS_LOAD_ADDR	0
-#define CONFIG_SYS_MAXARGS	15 /* max number of command args */
-#define CONFIG_SYS_LONGHELP
-#define CONFIG_AUTO_COMPLETE
-#define CONFIG_CMDLINE_EDITING

-#define CONFIG_SYS_HUSH_PARSER
-#define CONFIG_SYS_PROMPT_HUSH_PS2	"> "

 /* OF */
 #define CONFIG_FIT
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/232d1c0f/attachment.sig>
