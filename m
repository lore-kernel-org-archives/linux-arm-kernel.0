From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon,  7 Jun 2010 07:18:28 +0200
Subject: [PATCH 2/2] pxa/spitz: Add isl6271a voltage regulator
In-Reply-To: <1275887908-22285-1-git-send-email-marek.vasut@gmail.com>
References: <1275887908-22285-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1275887908-22285-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/spitz.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index c1048a3..97c207d 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -709,6 +709,13 @@ static struct platform_device sharpsl_rom_device = {
 	.dev.platform_data = &sharpsl_rom_data,
 };
 
+static struct i2c_board_info spitz_pi2c_board_info[] = {
+	{
+		.type		= "isl6271a",
+		.addr		= 0x1b,
+	},
+};
+
 static struct platform_device *devices[] __initdata = {
 	&spitzscoop_device,
 	&spitzkbd_device,
@@ -765,6 +772,9 @@ static void __init common_init(void)
 	pxa_set_ficp_info(&spitz_ficp_platform_data);
 	set_pxa_fb_info(&spitz_pxafb_info);
 	pxa_set_i2c_info(NULL);
+
+	pxa27x_set_i2c_power_info(NULL);
+	i2c_register_board_info(1, ARRAY_AND_SIZE(spitz_pi2c_board_info));
 }
 
 #if defined(CONFIG_MACH_AKITA) || defined(CONFIG_MACH_BORZOI)
-- 
1.7.1
