From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Thu, 12 Jul 2012 06:52:18 +0200
Subject: Build error with [PATCH v10 3/4] drivers/i2c/busses/i2c-at91.c
In-Reply-To: <CAFLc3brYJGkQoW5mGi9XaujNBMBdGX6RxfkNRbBZJQz_axz_Jg@mail.gmail.com>
References: <CAFLc3brYJGkQoW5mGi9XaujNBMBdGX6RxfkNRbBZJQz_axz_Jg@mail.gmail.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EA1AA99@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

Stefano Salati wrote on 2012-07-11:
> Thank you for publishing your patches! I'm using a at91sam9x5 board and I've
> been trying to patch the TWI so to be able to use the physical I2C module.
> When compiling, I get this error:
> 
> |   CC      drivers/i2c/busses/i2c-at91.o |
> drivers/i2c/busses/i2c-at91.c: In function 'at91_twi_probe': |
> drivers/i2c/busses/i2c-at91.c:350:2: error: implicit declaration of
> function 'clk_prepare' | drivers/i2c/busses/i2c-at91.c:394:2: error:
> implicit declaration of function 'clk_unprepare'
> 
> I tried to grep these these 2 functions in the whole /linux-2.6.39 but I had
> no luck, I cannot find any declaration (even in files belonging to the board
> you've designed the patch for).
> Where I'm missing something?

the driver is designed for kernel 3.2 or newer, nevertheless it should work
on older kernels with slight modifications. You can simply delete the
clk_prepare()/unprepare() stuff for your kernel version.

Please report the SoC and I2C clients you tested the driver with, preferably
with a Tested-by tag, so I can include it in newer versions of the driver
to improve the chance of mainlining the driver.

Niko
