From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Jun 2018 09:53:07 +0200
Subject: [PATCH] ARM: pxa, regulator: fix building ezx e680
In-Reply-To: <20180530212514.346474-1-arnd@arndb.de>
References: <20180530212514.346474-1-arnd@arndb.de>
Message-ID: <CACRpkdYzniSdUxbDrdKDaWuwH9iWNrEBGB6fJgGkiJTMh8nVhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 11:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The reference to camera_supply_gpiod_table was added in the wrong function,
> as observed from this randconfig build failure:
>
> arch/arm/mach-pxa/ezx.c: In function 'e680_init':
> arch/arm/mach-pxa/ezx.c:905:26: error: 'camera_supply_gpiod_table' undeclared (first use in this function)
>   gpiod_add_lookup_table(&camera_supply_gpiod_table);
>
> Fixes: 6059577cb28d ("regulator: fixed: Convert to use GPIO descriptor only")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have folded this into my patch as we are deferring this
change to the next kernel cycle.

Yours,
Linus Walleij
