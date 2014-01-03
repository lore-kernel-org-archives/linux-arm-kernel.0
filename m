From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:56 +0100
Subject: [PATCH v1 11/24] zynq: Enable cache options
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <911de6ba9b539c7ad2cb06a1a613544ca718c73b.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

- Enable cache command
- Turn-off L2 cache
- Turn-on D-cache

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index 44ae5ed..3938b54 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -16,6 +16,16 @@
 # define CONFIG_CPU_FREQ_HZ	800000000
 #endif

+/* Cache options */
+#define CONFIG_CMD_CACHE
+#define CONFIG_SYS_CACHELINE_SIZE	32
+
+#define CONFIG_SYS_L2CACHE_OFF
+#ifndef CONFIG_SYS_L2CACHE_OFF
+# define CONFIG_SYS_L2_PL310
+# define CONFIG_SYS_PL310_BASE		0xf8f02000
+#endif
+
 /* Serial drivers */
 #define CONFIG_BAUDRATE		115200
 /* The following table includes the supported baudrates */
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/376c283b/attachment.sig>
