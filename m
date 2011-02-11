From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 11 Feb 2011 18:27:51 +0100
Subject: [PATCH v2 1/3] ARM: S5PV210: Enable I2C0 bus on GONI board
In-Reply-To: <1297445273-3829-1-git-send-email-s.nawrocki@samsung.com>
References: <1297445273-3829-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1297445273-3829-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C0 bus platform device for camera sensors.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <@samsung.com>
---
 arch/arm/mach-s5pv210/mach-goni.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index db16d72..7a7cf6a 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -773,6 +773,7 @@ static struct platform_device *goni_devices[] __initdata = {
 	&goni_i2c_gpio5,
 	&mmc2_fixed_voltage,
 	&goni_device_gpiokeys,
+	&s3c_device_i2c0,
 	&s5p_device_fimc0,
 	&s5p_device_fimc1,
 	&s5p_device_fimc2,
@@ -809,6 +810,9 @@ static void __init goni_machine_init(void)
 	/* Radio: call before I2C 1 registeration */
 	goni_radio_init();
 
+	/* I2C0 */
+	s3c_i2c0_set_platdata(NULL);
+
 	/* I2C1 */
 	s3c_i2c1_set_platdata(NULL);
 	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
-- 
1.7.4
