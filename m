From: shawn.gsc@gmail.com (Shawn Guo)
Date: Fri, 22 Oct 2010 00:55:20 +0800
Subject: [PATCH] babbage: esdhc device registration
In-Reply-To: <1287680120-11354-1-git-send-email-shawn.gsc@gmail.com>
References: <1287680120-11354-1-git-send-email-shawn.gsc@gmail.com>
Message-ID: <1287680120-11354-2-git-send-email-shawn.gsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update babbage board support to register esdhc device

Signed-off-by: Shawn Guo <shawn.gsc@gmail.com>
---
 arch/arm/mach-mx5/Kconfig              |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index a2df9ac..fe96cd2 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -13,6 +13,7 @@ config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_ESDHC
 	help
 	  Include support for MX51 Babbage platform, also known as MX51EVK in
 	  u-boot. This includes specific configurations for the board and its
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 23ee4a4..39304b4 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -112,6 +112,22 @@ static struct pad_desc mx51babbage_pads[] = {
 
 	/* FEC PHY reset line */
 	MX51_PAD_EIM_A20__GPIO_2_14,
+
+	/* SD 1 */
+	MX51_PAD_SD1_CMD__SD1_CMD,
+	MX51_PAD_SD1_CLK__SD1_CLK,
+	MX51_PAD_SD1_DATA0__SD1_DATA0,
+	MX51_PAD_SD1_DATA1__SD1_DATA1,
+	MX51_PAD_SD1_DATA2__SD1_DATA2,
+	MX51_PAD_SD1_DATA3__SD1_DATA3,
+
+	/* SD 2 */
+	MX51_PAD_SD2_CMD__SD2_CMD,
+	MX51_PAD_SD2_CLK__SD2_CLK,
+	MX51_PAD_SD2_DATA0__SD2_DATA0,
+	MX51_PAD_SD2_DATA1__SD2_DATA1,
+	MX51_PAD_SD2_DATA2__SD2_DATA2,
+	MX51_PAD_SD2_DATA3__SD2_DATA3,
 };
 
 /* Serial ports */
@@ -304,6 +320,9 @@ static void __init mxc_board_init(void)
 	/* setback USBH1_STP to be function */
 	mxc_iomux_v3_setup_pad(&usbh1stp);
 	babbage_usbhub_reset();
+
+	imx51_add_esdhc(0, NULL);
+	imx51_add_esdhc(1, NULL);
 }
 
 static void __init mx51_babbage_timer_init(void)
-- 
1.7.1
