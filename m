From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Feb 2012 18:06:46 +0100
Subject: [PATCH 6/6] ARM: ux500: select I2C for U8500
In-Reply-To: <201202291703.33907.arnd@arndb.de>
References: <1330199334-5133-1-git-send-email-mathieu.poirier@linaro.org>
 <201202291634.41686.arnd@arndb.de>
 <CACRpkdaYmScZKq9rT1z1MEQ4WwJC8Ow7vyS8zBB4r5Q7o6YJTQ@mail.gmail.com>
 <201202291703.33907.arnd@arndb.de>
Message-ID: <CACRpkda8P5pv4m2hwP8fWNnpmZb-cBJBhkyYEtzet69vBpVJvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 6:03 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I got one more build error when actually disabling CONFIG_I2C on ux500:
>
> arnd at klappe2:~/linux-arm$ make O=obj-arm/ ?ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -s ?-j3 -k
> /git/arnd/linux-arm/arch/arm/mach-ux500/board-mop500-uib.c: In function 'mop500_uib_i2c_add':
> /git/arnd/linux-arm/arch/arm/mach-ux500/board-mop500-uib.c:74:2: error: implicit declaration of function 'i2c_get_adapter' [-Werror=implicit-function-declaration]
> /git/arnd/linux-arm/arch/arm/mach-ux500/board-mop500-uib.c:81:3: error: implicit declaration of function 'i2c_new_device' [-Werror=implicit-function-declaration]
> /git/arnd/linux-arm/arch/arm/mach-ux500/board-mop500-uib.c:121:2: error: implicit declaration of function 'i2c_smbus_xfer' [-Werror=implicit-function-declaration]
>
> I guess those need to be fixed, too. Ideally the API could just
> get stubbed out for !CONFIG_I2C, but it might be easier to
> conditionally build the code using it.

Hm in this case it's the code probing the board using I2C to figure out if it's
this or that variant.

So selecting this board needs to select I2C and I2C_NOMADIK to work
properly, I'll see if I can reproduce and think of something.

Yours,
Linus Walleij
