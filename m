From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Feb 2016 15:44:42 +0100
Subject: [PATCH 3/3] thermal: allow u8500-thermal driver to be a module
In-Reply-To: <1453740264-1972562-4-git-send-email-arnd@arndb.de>
References: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
 <1453740264-1972562-4-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYUERZwbEi6cP=heVk+nzcsrG=evE=AsrOL7onf7bYX-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 5:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> When the thermal subsystem is a loadable module, the u8500 driver
> fails to build:
>
> drivers/thermal/built-in.o: In function `db8500_thermal_probe':
> db8500_thermal.c:(.text+0x96c): undefined reference to `thermal_zone_device_register'
> drivers/thermal/built-in.o: In function `db8500_thermal_work':
> db8500_thermal.c:(.text+0xab4): undefined reference to `thermal_zone_device_update'
>
> This changes the symbol to a tristate, so Kconfig can track the
> dependency correctly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
