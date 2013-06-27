From: vincent.stehle@freescale.com (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Thu, 27 Jun 2013 14:42:41 +0200
Subject: [PATCH linux-next] arm: zynq: fix compilation warning
Message-ID: <1372336962-6459-1-git-send-email-vincent.stehle@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following compilation warning:

  arch/arm/mach-zynq/common.c:110:2: warning: initialization from incompatible pointer type [enabled by default]
  arch/arm/mach-zynq/common.c:110:2: warning: (near initialization for ?__mach_desc_XILINX_EP107.restart?) [enabled by default]

Signed-off-by: Vincent Stehl? <vincent.stehle@freescale.com>
Cc: Robin Holt <holt@sgi.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: trivial at kernel.org
---


Hi,

This warning was seen on linux-next tag next-20130627, with config ARM
multi_v7_defconfig.

Best regards,

V.


 arch/arm/mach-zynq/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 4130e65..8ea5f11 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -91,7 +91,7 @@ static void __init zynq_map_io(void)
 	zynq_scu_map_io();
 }
 
-static void zynq_system_reset(char mode, const char *cmd)
+static void zynq_system_reset(enum reboot_mode mode, const char *cmd)
 {
 	zynq_slcr_system_reset();
 }
-- 
1.7.10.4
