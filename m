From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:52 +0100
Subject: [PATCH v1 07/24] zynq: Enable Boot FreeBSD/vxWorks
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <18fc97ce09cb6da9342aaf41f9f52649ecaf8432.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

This enabled Boot FreeBSD/vxWorks from an ELF image support

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index 6019c4a..0492818 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -130,6 +130,13 @@
 #define CONFIG_FIT_VERBOSE	1 /* enable fit_format_{error,warning}() */
 #define CONFIG_OF_LIBFDT

+/* Boot FreeBSD/vxWorks from an ELF image */
+#if defined(CONFIG_ZYNQ_BOOT_FREEBSD)
+# define CONFIG_API
+# define CONFIG_CMD_ELF
+# define CONFIG_SYS_MMC_MAX_DEVICE	1
+#endif
+
 /* Commands */
 #include <config_cmd_default.h>

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/a958e755/attachment-0001.sig>
