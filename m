From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Mar 2012 17:13:45 +0100
Subject: [PATCH 10/10] ARM: ux500: Enable PL022 SSP Controller in Device
 Tree
In-Reply-To: <201203141405.50005.arnd@arndb.de>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
 <1331730306-11461-11-git-send-email-lee.jones@linaro.org>
 <201203141405.50005.arnd@arndb.de>
Message-ID: <CACRpkdYwwavBCk_P2oqfQOYNTGkucdHfZjNgWgwygx-f86==1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 3:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> For this to be functional, I think you also need a way for the SPI
> controller to find the child devices from the device tree, but I
> don't see how ux500 currently does it, or how it should be done.

It will be functional as long as you use the onholy hybrid of supplying
the SPI devices (like the I2C devices!) from the board files instead.

But both drivers/spi/spi-pl022.c and drivers/i2c/busses/i2c-nomadik.c
needs patches to register child devices from DT.

Yours,
Linus Walleij
