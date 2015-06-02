From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 2 Jun 2015 15:18:35 +0200
Subject: [PATCH v3 5/6] i2c: at91: print hardware version
In-Reply-To: <cover.1433250713.git.cyrille.pitchen@atmel.com>
References: <cover.1433250713.git.cyrille.pitchen@atmel.com>
Message-ID: <0634557b81f0c255411b2f64d78d570267d53b63.1433250713.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The probe() function now prints the hardware version of the I2C
controller.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 67b4f15..340ce2e 100644
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
@@ -872,6 +874,8 @@ static int at91_twi_probe(struct platform_device *pdev)
 			return rc;
 	}
 
+	dev_info(dev->dev, "version: 0x%x\n", at91_twi_read(dev, AT91_TWI_VER));
+
 	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
 			&bus_clk_rate);
 	if (rc)
-- 
1.8.2.2
