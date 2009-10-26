From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 26 Oct 2009 11:55:55 +0100
Subject: [PATCH 1/5] ARM: MX3: remove I2C defintions from mx31lilly.c
In-Reply-To: <1256554559-17828-1-git-send-email-daniel@caiaq.de>
References: <1256554559-17828-1-git-send-email-daniel@caiaq.de>
Message-ID: <1256554559-17828-2-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The module does not use these pins for I2C but for SPI.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mx31lilly.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lilly.c b/arch/arm/mach-mx3/mx31lilly.c
index 4230251..de5cf01 100644
--- a/arch/arm/mach-mx3/mx31lilly.c
+++ b/arch/arm/mach-mx3/mx31lilly.c
@@ -108,7 +108,6 @@ static struct platform_device physmap_flash_device = {
 static struct platform_device *devices[] __initdata = {
 	&smsc91x_device,
 	&physmap_flash_device,
-	&mxc_i2c_device1,
 };
 
 static int mx31lilly_baseboard;
@@ -128,8 +127,6 @@ static void __init mx31lilly_board_init(void)
 	}
 
 	mxc_iomux_alloc_pin(MX31_PIN_CS4__CS4, "Ethernet CS");
-	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_MOSI__SCL, "I2C SCL");
-	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_MISO__SDA, "I2C SDA");
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
-- 
1.6.5
