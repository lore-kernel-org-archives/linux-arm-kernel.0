From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 15 Oct 2009 19:31:07 +0200
Subject: [PATCH 3/4] [MXC] Armadillo500 Add i2c second bus support.
In-Reply-To: <20091015192905.2fa228f9@Marramao-laptop>
References: <20091015191325.74ba24fb@Marramao-laptop>
	<20091015192451.50ee35c5@Marramao-laptop>
	<20091015192905.2fa228f9@Marramao-laptop>
Message-ID: <20091015193107.2207de95@Marramao-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[PATCH] Armadillo500 Add i2c second bus support.

This add pin allocation an device registration for the 
second bus i2c.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 arch/arm/mach-mx3/armadillo5x0.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/armadillo5x0.c b/arch/arm/mach-mx3/armadillo5x0.c
index bd4a0f9..fa973e4 100644
--- a/arch/arm/mach-mx3/armadillo5x0.c
+++ b/arch/arm/mach-mx3/armadillo5x0.c
@@ -99,7 +99,11 @@ static int armadillo5x0_pins[] = {
 	MX31_PIN_FPSHIFT__FPSHIFT,
 	MX31_PIN_DRDY0__DRDY0,
 	IOMUX_MODE(MX31_PIN_LCS1, IOMUX_CONFIG_GPIO), /*ADV7125_PSAVE*/
+	/* I2C2 */
+	MX31_PIN_CSPI2_MOSI__SCL,
+	MX31_PIN_CSPI2_MISO__SDA,
 };
+
 /* GPIO BUTTONS */
 static struct gpio_keys_button armadillo5x0_buttons[] = {
 	{
@@ -332,6 +336,7 @@ static struct imxuart_platform_data uart_pdata = {
 
 static struct platform_device *devices[] __initdata = {
 	&armadillo5x0_smc911x_device,
+	&mxc_i2c_device1,
 	&armadillo5x0_button_device,
 };
 
-- 
1.5.4.3
