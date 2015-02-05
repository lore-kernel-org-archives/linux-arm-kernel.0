From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu,  5 Feb 2015 22:46:59 +0800
Subject: [PATCH 3/4] usb: dwc2: platform: add hi6220 support
In-Reply-To: <1423147620-5760-1-git-send-email-zhangfei.gao@linaro.org>
References: <1423147620-5760-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1423147620-5760-4-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/usb/dwc2/platform.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index ae095f0..ceee385 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -50,6 +50,34 @@
 
 static const char dwc2_driver_name[] = "dwc2";
 
+static const struct dwc2_core_params params_hi6220 = {
+	.otg_cap			= 2,	/* No HNP/SRP capable */
+	.otg_ver			= 0,	/* 1.3 */
+	.dma_enable			= 1,
+	.dma_desc_enable		= 0,
+	.speed				= 0,	/* High Speed */
+	.enable_dynamic_fifo		= 1,
+	.en_multiple_tx_fifo		= 1,
+	.host_rx_fifo_size		= 512,
+	.host_nperio_tx_fifo_size	= 512,
+	.host_perio_tx_fifo_size	= 512,
+	.max_transfer_size		= 65535,
+	.max_packet_count		= 511,
+	.host_channels			= 16,
+	.phy_type			= 1,	/* UTMI */
+	.phy_utmi_width			= 8,
+	.phy_ulpi_ddr			= 0,	/* Single */
+	.phy_ulpi_ext_vbus		= 0,
+	.i2c_enable			= 0,
+	.ulpi_fs_ls			= 0,
+	.host_support_fs_ls_low_power	= 0,
+	.host_ls_low_power_phy_clk	= 0,	/* 48 MHz */
+	.ts_dline			= 0,
+	.reload_ctl			= 0,
+	.ahbcfg				= 0x7 << GAHBCFG_HBSTLEN_SHIFT, /* INCR16 */
+	.uframe_sched			= 0,
+};
+
 static const struct dwc2_core_params params_bcm2835 = {
 	.otg_cap			= 0,	/* HNP/SRP capable */
 	.otg_ver			= 0,	/* 1.3 */
@@ -129,6 +157,7 @@ static int dwc2_driver_remove(struct platform_device *dev)
 
 static const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "brcm,bcm2835-usb", .data = &params_bcm2835 },
+	{ .compatible = "hisilicon,hi6220-usb", .data = &params_hi6220 },
 	{ .compatible = "rockchip,rk3066-usb", .data = &params_rk3066 },
 	{ .compatible = "snps,dwc2", .data = NULL },
 	{ .compatible = "samsung,s3c6400-hsotg", .data = NULL},
-- 
1.9.1
