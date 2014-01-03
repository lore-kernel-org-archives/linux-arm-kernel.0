From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 10:42:09 +0100
Subject: [PATCH 2/2] zynq: Enable dcache support
In-Reply-To: <521bc636ed31ff2958f8c95417b09036a523782c.1388742126.git.michal.simek@xilinx.com>
References: <521bc636ed31ff2958f8c95417b09036a523782c.1388742126.git.michal.simek@xilinx.com>
Message-ID: <7bfa25088eeec1176f0fad0f3e018837f2feb116.1388742126.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable dcache.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/cpu/armv7/zynq/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/cpu/armv7/zynq/cpu.c b/arch/arm/cpu/armv7/zynq/cpu.c
index 9af340e..c771759 100644
--- a/arch/arm/cpu/armv7/zynq/cpu.c
+++ b/arch/arm/cpu/armv7/zynq/cpu.c
@@ -46,3 +46,11 @@ void reset_cpu(ulong addr)
 	while (1)
 		;
 }
+
+#ifndef CONFIG_SYS_DCACHE_OFF
+void enable_caches(void)
+{
+	/* Enable D-cache. I-cache is already enabled in start.S */
+	dcache_enable();
+}
+#endif
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/c14c41fa/attachment.sig>
