From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 15 Jun 2017 20:49:22 +0200
Subject: [RESEND PATCH v6 2/8] mfd: retu: Drop -mfd suffix from I2C device ID
 name
In-Reply-To: <20170615184928.12007-1-javier@dowhile0.org>
References: <20170615184928.12007-1-javier@dowhile0.org>
Message-ID: <20170615184928.12007-3-javier@dowhile0.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not correct to encode the subsystem in the I2C device name, so
drop the -mfd suffix. To maintain bisect-ability, change driver and
platform code / DTS users in the same patch.

Suggested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>

---

Changes in v6:
- Add Wolfram Sang's Reviewed-by tag.

Changes in v5:
- Add Rob Herring's Acked-by tag.
- Add Aaro Koskinen's Acked-by tag.
- Add Tony Lindgren's Acked-by tag.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 4 ++--
 arch/arm/mach-omap1/board-nokia770.c        | 4 ++--
 drivers/mfd/retu-mfd.c                      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index 7e5ffc583c90..1b06430c8013 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -15,8 +15,8 @@
 				>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			retu_mfd: retu at 1 {
-				compatible = "retu-mfd";
+			retu: retu at 1 {
+				compatible = "retu";
 				interrupt-parent = <&gpio4>;
 				interrupts = <12 IRQ_TYPE_EDGE_RISING>;
 				reg = <0x1>;
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index ee8d9f553db4..06243c0b12d2 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -233,10 +233,10 @@ static struct platform_device nokia770_cbus_device = {
 
 static struct i2c_board_info nokia770_i2c_board_info_2[] __initdata = {
 	{
-		I2C_BOARD_INFO("retu-mfd", 0x01),
+		I2C_BOARD_INFO("retu", 0x01),
 	},
 	{
-		I2C_BOARD_INFO("tahvo-mfd", 0x02),
+		I2C_BOARD_INFO("tahvo", 0x02),
 	},
 };
 
diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
index d4c114abeb75..53e1d386d2c0 100644
--- a/drivers/mfd/retu-mfd.c
+++ b/drivers/mfd/retu-mfd.c
@@ -302,8 +302,8 @@ static int retu_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id retu_id[] = {
-	{ "retu-mfd", 0 },
-	{ "tahvo-mfd", 0 },
+	{ "retu", 0 },
+	{ "tahvo", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, retu_id);
-- 
2.9.3
