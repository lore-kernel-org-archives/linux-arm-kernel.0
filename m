From: kever.yang@rock-chips.com (Kever Yang)
Date: Tue, 29 Jul 2014 18:35:02 -0700
Subject: [PATCH 3/4] usb: dwc2: add compatible data for rockchip soc
In-Reply-To: <1406683873-18194-1-git-send-email-kever.yang@rock-chips.com>
References: <1406683873-18194-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1406684102-18313-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add compatible data for dwc2 controller found on
rk3066, rk3188 and rk3288 processors from rockchip.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---
 drivers/usb/dwc2/platform.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index a10e7a3..cc5983c 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -75,6 +75,34 @@ static const struct dwc2_core_params params_bcm2835 = {
 	.uframe_sched			= 0,
 };
 
+static const struct dwc2_core_params params_rk3066 = {
+	.otg_cap			= 2,	/* no HNP/SRP capable */
+	.otg_ver			= 0,	/* 1.3 */
+	.dma_enable			= 1,
+	.dma_desc_enable		= 0,
+	.speed				= 0,	/* High Speed */
+	.enable_dynamic_fifo		= 1,
+	.en_multiple_tx_fifo		= 1,
+	.host_rx_fifo_size		= 520,	/* 520 DWORDs */
+	.host_nperio_tx_fifo_size	= 128,	/* 128 DWORDs */
+	.host_perio_tx_fifo_size	= 256,	/* 256 DWORDs */
+	.max_transfer_size		= 65536,
+	.max_packet_count		= 512,
+	.host_channels			= 9,
+	.phy_type			= 1,	/* UTMI */
+	.phy_utmi_width			= 16,	/* 8 bits */
+	.phy_ulpi_ddr			= 0,	/* Single */
+	.phy_ulpi_ext_vbus		= 0,
+	.i2c_enable			= 0,
+	.ulpi_fs_ls			= 0,
+	.host_support_fs_ls_low_power	= 0,
+	.host_ls_low_power_phy_clk	= 0,	/* 48 MHz */
+	.ts_dline			= 0,
+	.reload_ctl			= 1,
+	.ahbcfg				= 0x17, /* dma enable &  INCR16 */
+	.uframe_sched			= 1,
+};
+
 /**
  * dwc2_driver_remove() - Called when the DWC_otg core is unregistered with the
  * DWC_otg driver
@@ -97,6 +125,7 @@ static int dwc2_driver_remove(struct platform_device *dev)
 
 static const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "brcm,bcm2835-usb", .data = &params_bcm2835 },
+	{ .compatible = "rockchip,rk3066-usb", .data = &params_rk3066 },
 	{ .compatible = "snps,dwc2", .data = NULL },
 	{},
 };
-- 
1.7.9.5
