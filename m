From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 31 Mar 2012 10:24:05 -0300
Subject: [PATCH] ARM: imx: fix mc9s08dz60_gpiochip_match parameter type
In-Reply-To: <1333183577-2109-1-git-send-email-shawn.guo@linaro.org>
References: <1333183577-2109-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOMZO5B3W6fuQDq=WHSovtOJFOsKF0as1kJGQ5Lm9MWkh71JeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Sat, Mar 31, 2012 at 5:46 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Due to the change made by commit 6e2cf65 (gpio: constify the data
> parameter to gpiochip_find()), the following compile warning is seen
> on imx_v6_v7_defconfig build.
>
> ?CC ? ? ?arch/arm/mach-imx/mach-mx35_3ds.o
> arch/arm/mach-imx/mach-mx35_3ds.c: In function ?mx35_3ds_lcd_set_power?:
> arch/arm/mach-imx/mach-mx35_3ds.c:112:5: warning: passing argument 2 of ?gpiochip_find? from incompatible pointer type [enabled by default]
> include/asm-generic/gpio.h:145:26: note: expected ?int (*)(struct gpio_chip *, const void *)? but argument is of type ?int (*)(struct gpio_chip *, void *)?
>
> Change mc9s08dz60_gpiochip_match parameter type accordingly to fix
> the warning.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I have already sent this fix:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/158438

Thanks,

Fabio Estevam
