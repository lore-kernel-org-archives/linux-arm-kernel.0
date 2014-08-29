From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 29 Aug 2014 16:12:12 +0200
Subject: [PATCH] ARM: zynq: Remove useless L2C AUX setting
Message-ID: <66d0f1762b6b76559794d86e85d31398c337d109.1409321528.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AUX setting has no effect that's why remove it.

Warning log:
L2C: platform provided aux values match the hardware, so
have no effect.  Please remove them.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/mach-zynq/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 31a6fa40ba37..151bcbcb0f67 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -198,8 +198,8 @@ static const char * const zynq_dt_match[] = {

 DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	/* 64KB way size, 8-way associativity, parity disabled */
-	.l2c_aux_val	= 0x02000000,
-	.l2c_aux_mask	= 0xf0ffffff,
+	.l2c_aux_val	= 0x00000000,
+	.l2c_aux_mask	= 0xffffffff,
 	.smp		= smp_ops(zynq_smp_ops),
 	.map_io		= zynq_map_io,
 	.init_irq	= zynq_irq_init,
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/50e185ed/attachment.sig>
