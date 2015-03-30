From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 30 Mar 2015 13:39:31 +0300
Subject: [PATCH 3/3] ARM: pxa: declare battery device on poodle
In-Reply-To: <1427711971-8164-1-git-send-email-dbaryshkov@gmail.com>
References: <1427711971-8164-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1427711971-8164-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare a battery platform device for SL-5600 (poodle) platform.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/poodle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 596e756..90d679a 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -466,6 +466,11 @@ static struct platform_device poodle_power_device = {
 	.dev.platform_data	= &poodle_power_data,
 };
 
+static struct platform_device poodle_battery_device = {
+	.name			= "poodle-battery",
+	.id			= -1,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&poodle_locomo_device,
 	&poodle_scoop_device,
@@ -474,6 +479,7 @@ static struct platform_device *devices[] __initdata = {
 	&sharpsl_nand_device,
 	&sharpsl_rom_device,
 	&poodle_power_device,
+	&poodle_battery_device,
 };
 
 static struct i2c_board_info __initdata poodle_i2c_devices[] = {
-- 
2.1.4
