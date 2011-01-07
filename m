From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 07 Jan 2011 17:57:46 +0100
Subject: [PATCH 1/3] ARM: S5PV210: Enable I2C0 bus on GONI board
In-Reply-To: <1294419468-13700-1-git-send-email-s.nawrocki@samsung.com>
References: <1294419468-13700-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1294419468-13700-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C0 bus platform device for camera sensors.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig     |    1 +
 arch/arm/mach-s5pv210/mach-goni.c |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 53aabef..b0aa462 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -75,6 +75,7 @@ config MACH_GONI
 	bool "GONI"
 	select CPU_S5PV210
 	select S5P_GPIO_INT
+	select S3C_DEV_I2C0
 	select S3C_DEV_FB
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index e22d511..fc34575 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -800,6 +800,7 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s5pv210_device_iis0,
 	&s3c_device_usb_hsotg,
 	&samsung_device_keypad,
+	&s3c_device_i2c0,
 	&s3c_device_i2c1,
 	&s3c_device_i2c2,
 	&wm8994_fixed_voltage0,
@@ -827,6 +828,9 @@ static void __init goni_machine_init(void)
 	/* Radio: call before I2C 1 registeration */
 	goni_radio_init();
 
+	/* I2C0 */
+	s3c_i2c0_set_platdata(NULL);
+
 	/* I2C1 */
 	s3c_i2c1_set_platdata(NULL);
 	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
-- 
1.7.3.5
