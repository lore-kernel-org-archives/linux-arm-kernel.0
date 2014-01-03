From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 10:42:08 +0100
Subject: [PATCH 1/2] zynq: Do not explicitely enable icache
Message-ID: <521bc636ed31ff2958f8c95417b09036a523782c.1388742126.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

icache is already enabled by default.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 board/xilinx/zynq/board.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index 5119c09..7c1632f 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -49,8 +49,6 @@ int board_init(void)
 	}
 #endif

-	icache_enable();
-
 #ifdef CONFIG_FPGA
 	fpga_init();
 	fpga_add(fpga_xilinx, &fpga);
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/2364a0db/attachment-0001.sig>
