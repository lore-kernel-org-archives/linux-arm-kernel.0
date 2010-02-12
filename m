From: mattias@vmlinux.org (Mattias Walstrom)
Date: Fri, 12 Feb 2010 23:15:51 +0100
Subject: i2c-imx: Autoprobe of eeproms
Message-ID: <4B75D317.7040801@vmlinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have tried to get autoprobe of eeproms to work on a custom freescale
mx27-board, and i found out that the i2c-imx driver was missing the
following, is there a reason for this, most other i2c-bus drivers seems
to have it?

--- linux-2.6.32.8.orig/drivers/i2c/busses/i2c-imx.c    2010-02-09
13:57:19.000000000 +0100
+++ linux-2.6.32.8/drivers/i2c/busses/i2c-imx.c 2010-02-12
11:30:12.000000000 +0100
@@ -521,6 +521,7 @@
        i2c_imx->adapter.algo           = &i2c_imx_algo;
        i2c_imx->adapter.dev.parent     = &pdev->dev;
        i2c_imx->adapter.nr             = pdev->id;
+        i2c_imx->adapter.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD;
        i2c_imx->irq                    = irq;
        i2c_imx->base                   = base;
        i2c_imx->res                    = res;


Best regards
Mattias Walstr?m
