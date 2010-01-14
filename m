From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 14 Jan 2010 11:24:15 +0200
Subject: [PATCH 3/3] mx25pdk: add NAND device support
In-Reply-To: <cover.1263460321.git.baruch@tkos.co.il>
References: <cover.1263460321.git.baruch@tkos.co.il>
Message-ID: <810d2b67056503ed2c38907bfe8f5d11aaeb15ac.1263460321.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/mx25pdk.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/mx25pdk.c b/arch/arm/mach-mx25/mx25pdk.c
index 921bc99..c8b1d3b 100644
--- a/arch/arm/mach-mx25/mx25pdk.c
+++ b/arch/arm/mach-mx25/mx25pdk.c
@@ -77,6 +77,12 @@ static void __init mx25pdk_fec_reset(void)
 	gpio_set_value(FEC_RESET_B_GPIO, 1);
 }
 
+static struct mxc_nand_platform_data mx25pdk_nand_board_info = {
+	.width		= 1,
+	.hw_ecc		= 1,
+	.flash_bbt	= 1,
+};
+
 static void __init mx25pdk_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx25pdk_pads,
@@ -84,6 +90,7 @@ static void __init mx25pdk_init(void)
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxc_usbh2, NULL);
+	mxc_register_device(&mxc_nand_device, &mx25pdk_nand_board_info);
 
 	mx25pdk_fec_reset();
 	mxc_register_device(&mx25_fec_device, &mx25_fec_pdata);
-- 
1.6.5
