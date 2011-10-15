From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sat, 15 Oct 2011 21:18:08 +0300
Subject: [PATCH v2] mach-ep93xx: break out GPIO driver specifics
In-Reply-To: <1316508132-20020-1-git-send-email-linus.walleij@stericsson.com>
References: <1316508132-20020-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20111015181808.GA3128@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 10:42:12AM +0200, Linus Walleij wrote:
>  arch/arm/mach-ep93xx/core.c                     |    1 +
>  arch/arm/mach-ep93xx/edb93xx.c                  |    1 +
>  arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h |  100 +++++++++++++++++++++
>  arch/arm/mach-ep93xx/include/mach/gpio.h        |  105 -----------------------

I just tried to compile latest linux-next and due to missing <mach/gpio.h> I
get:

In file included from include/linux/gpio.h:18:0,
                 from drivers/gpio/gpiolib.c:10:
/home/westeri/devel/kernel/linux/arch/arm/include/asm/gpio.h:5:23: fatal error: mach/gpio.h: No such file or directory
compilation terminated.
make[2]: *** [drivers/gpio/gpiolib.o] Error 1

It looks like arch/arm/include/asm/gpio.h wants to have <mach/gpio.h>. Any idea
how to fix this?
