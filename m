From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 14:02:55 +0200
Subject: [PATCH] ARM: U300: Add proper ifdef guard to fix build error when
 CONFIG_I2C_STU300=m
In-Reply-To: <1367824503.6190.1.camel@phoenix>
References: <1367824503.6190.1.camel@phoenix>
Message-ID: <CACRpkdYrN78Oae_4DKh6cdOWxiuNEZCQzicKKoN5dv1ws185LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 6, 2013 at 9:15 AM, Axel Lin <axel.lin@ingics.com> wrote:

> I got below build error if CONFIG_I2C_STU300=m.
>
> ERROR: "i2c_register_board_info" [arch/arm/mach-u300/i2c.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
>
> Fix it by adding proper ifdef guard in i2c.h and Makefile.
> So arch/arm/mach-u300/i2c.c will be compiled when CONFIG_I2C_STU300 is
> configured as built-in or as a module.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

This file will be deleted in v3.11, see:
http://marc.info/?l=linux-arm-kernel&m=136662534118633&w=2

Yours,
Linus Walleij
