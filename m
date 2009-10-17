From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 17 Oct 2009 15:12:57 +0200
Subject: [PATCH 1/4] ARM: MX3: remove I2C defintions from mx31lilly.c
In-Reply-To: <1255785180-18501-1-git-send-email-daniel@caiaq.de>
References: <1255785180-18501-1-git-send-email-daniel@caiaq.de>
Message-ID: <1255785180-18501-2-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The module does not use these pins for I2C but for SPI.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mx31lilly.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lilly.c b/arch/arm/mach-mx3/mx31lilly.c
index 0a93407..e0f4cd2 100644
--- a/arch/arm/mach-mx3/mx31lilly.c
+++ b/arch/arm/mach-mx3/mx31lilly.c
@@ -245,7 +245,6 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
 static struct platform_device *devices[] __initdata = {
 	&smsc91x_device,
 	&physmap_flash_device,
-	&mxc_i2c_device1,
 };
 
 static int mx31lilly_baseboard;
@@ -265,8 +264,6 @@ static void __init mx31lilly_board_init(void)
 	}
 
 	mxc_iomux_alloc_pin(MX31_PIN_CS4__CS4, "Ethernet CS");
-	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_MOSI__SCL, "I2C SCL");
-	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_MISO__SDA, "I2C SDA");
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-- 
1.6.3.3
