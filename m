From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:27 +0800
Subject: [PATCH 09/22] regulator: Change db8500-prcmu match names to reflect
 Device Tree
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'name' field in 'struct of_regulator_match' expects to match with
its corresponding regulator device node in the Device Tree. This patch
renames each of the regulators in the db8500-prcum regulator driver so
this is true.

Cc: linux-kernel at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/db8500-prcmu.c |   40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/db8500-prcmu.c b/drivers/regulator/db8500-prcmu.c
index 968f97f..9dbb491 100644
--- a/drivers/regulator/db8500-prcmu.c
+++ b/drivers/regulator/db8500-prcmu.c
@@ -452,26 +452,26 @@ static __devinit int db8500_regulator_register(struct platform_device *pdev,
 }
 
 static struct of_regulator_match db8500_regulator_matches[] = {
-	{ .name	= "db8500-vape",          .driver_data = (void *) DB8500_REGULATOR_VAPE, },
-	{ .name	= "db8500-varm",          .driver_data = (void *) DB8500_REGULATOR_VARM, },
-	{ .name	= "db8500-vmodem",        .driver_data = (void *) DB8500_REGULATOR_VMODEM, },
-	{ .name	= "db8500-vpll",          .driver_data = (void *) DB8500_REGULATOR_VPLL, },
-	{ .name	= "db8500-vsmps1",        .driver_data = (void *) DB8500_REGULATOR_VSMPS1, },
-	{ .name	= "db8500-vsmps2",        .driver_data = (void *) DB8500_REGULATOR_VSMPS2, },
-	{ .name	= "db8500-vsmps3",        .driver_data = (void *) DB8500_REGULATOR_VSMPS3, },
-	{ .name	= "db8500-vrf1",          .driver_data = (void *) DB8500_REGULATOR_VRF1, },
-	{ .name	= "db8500-sva-mmdsp",     .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAMMDSP, },
-	{ .name	= "db8500-sva-mmdsp-ret", .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAMMDSPRET, },
-	{ .name	= "db8500-sva-pipe",      .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAPIPE, },
-	{ .name	= "db8500-sia-mmdsp",     .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAMMDSP, },
-	{ .name	= "db8500-sia-mmdsp-ret", .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAMMDSPRET, },
-	{ .name	= "db8500-sia-pipe",      .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAPIPE, },
-	{ .name	= "db8500-sga",           .driver_data = (void *) DB8500_REGULATOR_SWITCH_SGA, },
-	{ .name	= "db8500-b2r2-mcde",     .driver_data = (void *) DB8500_REGULATOR_SWITCH_B2R2_MCDE, },
-	{ .name	= "db8500-esram12",       .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM12, },
-	{ .name	= "db8500-esram12-ret",   .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM12RET, },
-	{ .name	= "db8500-esram34",       .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM34, },
-	{ .name	= "db8500-esram34-ret",   .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM34RET, },
+	{ .name	= "db8500_vape",          .driver_data = (void *) DB8500_REGULATOR_VAPE, },
+	{ .name	= "db8500_varm",          .driver_data = (void *) DB8500_REGULATOR_VARM, },
+	{ .name	= "db8500_vmodem",        .driver_data = (void *) DB8500_REGULATOR_VMODEM, },
+	{ .name	= "db8500_vpll",          .driver_data = (void *) DB8500_REGULATOR_VPLL, },
+	{ .name	= "db8500_vsmps1",        .driver_data = (void *) DB8500_REGULATOR_VSMPS1, },
+	{ .name	= "db8500_vsmps2",        .driver_data = (void *) DB8500_REGULATOR_VSMPS2, },
+	{ .name	= "db8500_vsmps3",        .driver_data = (void *) DB8500_REGULATOR_VSMPS3, },
+	{ .name	= "db8500_vrf1",          .driver_data = (void *) DB8500_REGULATOR_VRF1, },
+	{ .name	= "db8500_sva_mmdsp",     .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAMMDSP, },
+	{ .name	= "db8500_sva_mmdsp_ret", .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAMMDSPRET, },
+	{ .name	= "db8500_sva_pipe",      .driver_data = (void *) DB8500_REGULATOR_SWITCH_SVAPIPE, },
+	{ .name	= "db8500_sia_mmdsp",     .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAMMDSP, },
+	{ .name	= "db8500_sia_mmdsp_ret", .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAMMDSPRET, },
+	{ .name	= "db8500_sia_pipe",      .driver_data = (void *) DB8500_REGULATOR_SWITCH_SIAPIPE, },
+	{ .name	= "db8500_sga",           .driver_data = (void *) DB8500_REGULATOR_SWITCH_SGA, },
+	{ .name	= "db8500_b2r2_mcde",     .driver_data = (void *) DB8500_REGULATOR_SWITCH_B2R2_MCDE, },
+	{ .name	= "db8500_esram12",       .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM12, },
+	{ .name	= "db8500_esram12_ret",   .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM12RET, },
+	{ .name	= "db8500_esram34",       .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM34, },
+	{ .name	= "db8500_esram34_ret",   .driver_data = (void *) DB8500_REGULATOR_SWITCH_ESRAM34RET, },
 };
 
 static __devinit int
-- 
1.7.9.5
