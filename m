From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 12 Jun 2012 10:57:41 +0200
Subject: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <4FD70357.9060905@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <20120611190550.GK3887@pengutronix.de>
 <4FD70357.9060905@linaro.org>
Message-ID: <20120612085741.GD9230@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 09:52:39AM +0100, Lee Jones wrote:
> From: Lee Jones <lee.jones@linaro.org>
> Date: Tue, 17 Apr 2012 16:04:13 +0100
> Subject: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C driver
> 
> Here we move the i2c-nomadik's default settings into the driver
> rather than specifying them from platform code. At the time of
> this writing we only have one user, the u8500. As new users are
> added, it is expected that they will be Device Tree compliant.
> If this is the case, we will look up their initialisation values
> by compatible entry, then apply them forthwith.
> 
> Cc: linux-i2c at vger.kernel.org
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Did you use checkpatch?

============

Applying: i2c: Add Device Tree support to the Nomadik I2C driver
  CHECKPATCH
WARNING: please, no space before tabs
#37: FILE: drivers/i2c/busses/i2c-nomadik.c:909:
+^I.tft            = 1, ^I  /* Tx FIFO threshold */$

WARNING: please, no space before tabs
#38: FILE: drivers/i2c/busses/i2c-nomadik.c:910:
+^I.rft            = 8, ^I  /* Rx FIFO threshold */$

WARNING: please, no space before tabs
#40: FILE: drivers/i2c/busses/i2c-nomadik.c:912:
+^I.timeout        = 200, ^I  /* Slave response timeout(ms) */$

ERROR: code indent should use tabs where possible
#56: FILE: drivers/i2c/busses/i2c-nomadik.c:927:
+        const struct of_device_id *of_id =$

WARNING: please, no spaces at the start of a line
#56: FILE: drivers/i2c/busses/i2c-nomadik.c:927:
+        const struct of_device_id *of_id =$

ERROR: code indent should use tabs where possible
#57: FILE: drivers/i2c/busses/i2c-nomadik.c:928:
+                        of_match_device(nmk_gpio_match, &pdev->dev);$

WARNING: please, no spaces at the start of a line
#57: FILE: drivers/i2c/busses/i2c-nomadik.c:928:
+                        of_match_device(nmk_gpio_match, &pdev->dev);$

total: 2 errors, 5 warnings, 0 checks, 59 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
      scripts/cleanfile

Your patch has style problems, please review.

============

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120612/50a7ba22/attachment.sig>
