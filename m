From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 1 Jun 2015 17:49:14 +0200
Subject: [PATCH v2 4/5] i2c: at91: print hardware version
In-Reply-To: <cover.1433173031.git.cyrille.pitchen@atmel.com>
References: <cover.1433173031.git.cyrille.pitchen@atmel.com>
Message-ID: <46a3699a9449adb793a97f212d38224f33488c87.1433173031.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The probe() function now prints the hardware version of the I2C controller

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index e926806..ecf601a 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -85,6 +85,8 @@
 #define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
 #define	AT91_TWI_ACR_DIR	BIT(8)
 
+#define	AT91_TWI_VER		0x00fc	/* Version Register */
+
 struct at91_twi_pdata {
 	unsigned clk_max_div;
 	unsigned clk_offset;
@@ -870,6 +872,8 @@ static int at91_twi_probe(struct platform_device *pdev)
 			return rc;
 	}
 
+	dev_info(dev->dev, "version: 0x%x\n", at91_twi_read(dev, AT91_TWI_VER));
+
 	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
 			&bus_clk_rate);
 	if (rc)
-- 
1.8.2.2
