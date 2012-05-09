From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 May 2012 10:46:53 +0200
Subject: [PATCH 02/15] ARM: ux500: Remove unused i2c platform_data
 initialisation code
In-Reply-To: <1336155805-18554-3-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ70FasMuTTgBe68xaePB-4UNZ0W44BCxDve7fqXYT+vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 8:23 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Now that u5500 is obsolete, u8500 is the only user of the Nomadik
> i2c driver.

Well actually arch/arm/mach-nomadik has this block too,
but it's not making use of it right now, so why not.

> As such there is no requirement to differentiate between
> initialisation values. By the time a new SoC is released, almost all
> of the ux500 platform will be DT:ed, so we can make decisions based
> on the compatible property instead.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

So why not copy the contents of arch/arm/plat-nomadik/include/plat/i2c.h
into drivers/i2c/busses/i2c-nomadik.c and delete that header from
plat at the same time?

Then there sure is no way for platforms to sneak in any platform
data any other way.

Yours,
Linus Walleij
