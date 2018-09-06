From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Sep 2018 23:33:04 +0800
Subject: [PATCH resend] mmc: sunxi: Use new timing mode for A64 eMMC controller
Message-ID: <20180906153304.22239-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC controller is also a new timing mode controller, but it doesn't
have the timing mode switch. It does however have signal delay and
calibration controls, typical of Allwinner MMC controllers that support
the new timing mode.

Enable the new timing mode setting for the A64 eMMC controller. This
also enables MMC HS-DDR modes, which gives higher throughput for eMMC
chips that support it, and can deliver such throughput.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This is just a resend. A separate patch clarifying the usage of the new
timing mode should meet Maxime's request for comments clarifying the
new timing mode usage from the initial submission of this patch.

---
 drivers/mmc/host/sunxi-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 5f8d3ea0a0f8..279e326e397e 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1177,6 +1177,7 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
 	.idma_des_size_bits = 13,
 	.clk_delays = NULL,
 	.can_calibrate = true,
+	.needs_new_timings = true,
 };
 
 static const struct of_device_id sunxi_mmc_of_match[] = {
-- 
2.19.0.rc1
