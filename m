From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 20 Nov 2014 23:04:39 -0600
Subject: [PATCH 1/2] arm: socfpga: update l2 cache settings
Message-ID: <1416546280-12068-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Enable D and I prefetch helps improve SDRAM preformance.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/mach-socfpga/socfpga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index adbf383..13b1858 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -104,7 +104,8 @@ static const char *altera_dt_match[] = {
 };
 
 DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
-	.l2c_aux_val	= 0,
+	.l2c_aux_val	= L310_AUX_CTRL_DATA_PREFETCH |
+			  L310_AUX_CTRL_INSTR_PREFETCH,
 	.l2c_aux_mask	= ~0,
 	.smp		= smp_ops(socfpga_smp_ops),
 	.map_io		= socfpga_map_io,
-- 
2.0.3
