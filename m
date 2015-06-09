From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 9 Jun 2015 18:22:18 +0200
Subject: [PATCH v6 5/6] i2c: at91: print hardware version
In-Reply-To: <cover.1433866582.git.cyrille.pitchen@atmel.com>
References: <cover.1433866582.git.cyrille.pitchen@atmel.com>
Message-ID: <d1fbf4bce3b470409ef3198f551cfc3f8f22ac78.1433866582.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The probe() function now prints the hardware version of the I2C
controller.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 817ae69..6e88b30 100644
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
@@ -908,7 +910,8 @@ static int at91_twi_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	dev_info(dev->dev, "AT91 i2c bus driver.\n");
+	dev_info(dev->dev, "AT91 i2c bus driver (version: %#x).\n",
+		 at91_twi_read(dev, AT91_TWI_VER));
 	return 0;
 }
 
-- 
1.8.2.2
