From: sguinot@lacie.com (Simon Guinot)
Date: Tue,  9 Feb 2010 21:21:49 +0100
Subject: [PATCH 1/2] [ARM] Orion5x: set valid GPIO inhibit power-off for d2net
Message-ID: <1265746910-21982-1-git-send-email-sguinot@lacie.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allow user-space to configure the switch power-off behaviour
via the gpiolib sysfs interface.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 arch/arm/mach-orion5x/d2net-setup.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-orion5x/d2net-setup.c b/arch/arm/mach-orion5x/d2net-setup.c
index 9d4bf76..0420e45 100644
--- a/arch/arm/mach-orion5x/d2net-setup.c
+++ b/arch/arm/mach-orion5x/d2net-setup.c
@@ -301,6 +301,8 @@ static struct orion5x_mpp_mode d2net_mpp_modes[] __initdata = {
 	/* 24: Inhibit board power off (0 = Disabled, 1 = Enabled) */
 };
 
+#define D2NET_GPIO_INHIBIT_POWER_OFF    24
+
 static void __init d2net_init(void)
 {
 	/*
@@ -333,6 +335,8 @@ static void __init d2net_init(void)
 
 	i2c_register_board_info(0, d2net_i2c_devices,
 				ARRAY_SIZE(d2net_i2c_devices));
+
+	orion_gpio_set_valid(D2NET_GPIO_INHIBIT_POWER_OFF, 1);
 }
 
 /* Warning: LaCie use a wrong mach-type (0x20e=526) in their bootloader. */
-- 
1.6.3.1
