From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Aug 2013 23:19:12 +0200
Subject: [PATCH 09/33] ARM: ux500: Supply the I2C clocks lookup to the
 DBX500 DT
In-Reply-To: <20130822154116.GC17154@lee--X1>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdbE86HgPr+7LZD9BFU_OsDFFFWTaFHW_i2fNXivKZ-3Dw@mail.gmail.com>
 <20130820093034.GL31036@pengutronix.de>
 <20130822133730.GB23152@e106331-lin.cambridge.arm.com>
 <20130822141900.GB17154@lee--X1>
 <20130822151723.GE23152@e106331-lin.cambridge.arm.com>
 <20130822154116.GC17154@lee--X1>
Message-ID: <20130822211912.GE31036@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 04:41:16PM +0100, Lee Jones wrote:
> 
> When most of the other clocks that we deal with are being requested,
> they rely on being index zero:
> 
>   drivers/i2c/busses/i2c-nomadik.c: dev->clk = clk_get(&adev->dev, NULL);

Once a device has more than a single clock all clocks should have a
connection id. clk_get(dev, NULL) should only be used for single clock
devices. Look at drivers/clk/clkdev.c, there's some fuzzy matching
involved when you pass NULL as connection id.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
