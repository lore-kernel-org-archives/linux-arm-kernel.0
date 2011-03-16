From: Dinh.Nguyen@freescale.com (Dinh.Nguyen at freescale.com)
Date: Wed, 16 Mar 2011 15:03:05 -0500
Subject: [PATCHv3 1/3] ARM: mx51: Add entry for gpc_dvfs_clk
Message-ID: <1300305787-7970-1-git-send-email-Dinh.Nguyen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <Dinh.Nguyen@freescale.com>

For MX51 SRPG, we need to turn on the GPC clock in order to set the
SRPG registers.

Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 652ace4..18492fa 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -865,6 +865,13 @@ static struct clk aips_tz2_clk = {
 	.disable = _clk_ccgr_disable_inwait,
 };
 
+static struct clk gpc_dvfs_clk = {
+	.enable_reg = MXC_CCM_CCGR5,
+	.enable_shift = MXC_CCM_CCGRx_CG12_OFFSET,
+	.enable = _clk_ccgr_enable,
+	.disable = _clk_ccgr_disable,
+};
+
 static struct clk gpt_32k_clk = {
 	.id = 0,
 	.parent = &ckil_clk,
@@ -1448,6 +1455,7 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("imx-ipuv3", NULL, ipu_clk)
 	_REGISTER_CLOCK("imx-ipuv3", "di0", ipu_di0_clk)
 	_REGISTER_CLOCK("imx-ipuv3", "di1", ipu_di1_clk)
+	_REGISTER_CLOCK(NULL, "gpc_dvfs_clk", gpc_dvfs_clk)
 };
 
 static struct clk_lookup mx53_lookups[] = {
-- 
1.6.0.4
