From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 17 Jun 2010 20:59:06 +0200
Subject: [PATCH] mach-mx3/mach-mx31_3ds: update keypad registration
In-Reply-To: <1276801147-4103-5-git-send-email-eric@eukrea.com>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
	<1276801147-4103-2-git-send-email-eric@eukrea.com>
	<1276801147-4103-3-git-send-email-eric@eukrea.com>
	<1276801147-4103-4-git-send-email-eric@eukrea.com>
	<1276801147-4103-5-git-send-email-eric@eukrea.com>
Message-ID: <1276801147-4103-6-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

depends on "input/imx_keypad: add PM support"
Note : this patch is not tested

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: s.hauer at pengutronix.de
Cc: linux-arm-kernel at lists.infradead.org
Cc: maramaopercheseimorto at gmail.com
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 58e5729..04c8700 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -114,6 +114,11 @@ static struct matrix_keymap_data mx31_3ds_keymap_data = {
 	.keymap_size	= ARRAY_SIZE(mx31_3ds_keymap),
 };
 
+static struct matrix_keypad_platform_data mx31_3ds_keypad_data = {
+	.keymap_data	= &mx31_3ds_keymap_data,
+	.wakeup		= 1,
+};
+
 /* Regulators */
 static struct regulator_init_data pwgtx_init = {
 	.constraints = {
@@ -397,7 +402,7 @@ static void __init mxc_board_init(void)
 	spi_register_board_info(mx31_3ds_spi_devs,
 						ARRAY_SIZE(mx31_3ds_spi_devs));
 
-	mxc_register_device(&imx_kpp_device, &mx31_3ds_keymap_data);
+	mxc_register_device(&imx_kpp_device, &mx31_3ds_keypad_data);
 
 	mx31_3ds_usbotg_init();
 	mxc_register_device(&mxc_otg_udc_device, &usbotg_pdata);
-- 
1.6.3.3
