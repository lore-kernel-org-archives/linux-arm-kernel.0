From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Jun 2011 08:30:25 +0200
Subject: [PATCH] mach-ux500: fix build error due to unknown 'regulator_en'
	field
In-Reply-To: <1309354437.10872.1.camel@phoenix>
References: <1309354437.10872.1.camel@phoenix>
Message-ID: <BANLkTinkonRXwLC8QanmwYXjmWq=Gtp=hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Axel,

On Wed, Jun 29, 2011 at 3:33 PM, Axel Lin <axel.lin@gmail.com> wrote:

> Fix below build error:
>
>  CC      arch/arm/mach-ux500/board-mop500-u8500uib.o
> arch/arm/mach-ux500/board-mop500-u8500uib.c:35: error: unknown field 'regulator_en' specified in initializer
> arch/arm/mach-ux500/board-mop500-u8500uib.c:35: warning: excess elements in struct initializer
> arch/arm/mach-ux500/board-mop500-u8500uib.c:35: warning: (near initialization for 'rmi4_i2c_dev_platformdata')
> make[1]: *** [arch/arm/mach-ux500/board-mop500-u8500uib.o] Error 1
> make: *** [arch/arm/mach-ux500] Error 2

But uh-oh, that expose our disobedience to the rule that we shall not have
cross-dependencies from stable machines to stuff in staging.

It's tricky this time, since that I2C device is added after first probing
the I2C bus for board type, but I think I have a solution, hold on for
another patch.

Linus Walleij
