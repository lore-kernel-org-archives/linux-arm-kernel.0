From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 29 May 2015 15:50:09 +0200
Subject: [PATCH 2/3] i2c: at91: print hardware version
In-Reply-To: <cover.1432907105.git.cyrille.pitchen@atmel.com>
References: <cover.1432907105.git.cyrille.pitchen@atmel.com>
Message-ID: <5d08690d152e10592443224b46b677071196f730.1432907105.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The probe() function now prints the hardware version of the I2C controller

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index b48be58..1549b29 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -85,6 +85,8 @@
 #define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
 #define	AT91_TWI_ACR_DIR	(1 << 8)
 
+#define	AT91_TWI_VER		0x00fc	/* Version Register */
+
 struct at91_twi_pdata {
 	unsigned clk_max_div;
 	unsigned clk_offset;
@@ -867,6 +869,8 @@ static int at91_twi_probe(struct platform_device *pdev)
 			return rc;
 	}
 
+	dev_info(dev->dev, "version: 0x%x\n", at91_twi_read(dev, AT91_TWI_VER));
+
 	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
 			&bus_clk_rate);
 	if (rc)
-- 
1.8.2.2
