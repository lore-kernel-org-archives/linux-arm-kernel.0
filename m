From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Mar 2013 08:36:33 +0100
Subject: [PATCH] mfd: Fix AB8500 build failure if POWER_SUPPLY is not
 configured
In-Reply-To: <1362080229-27334-1-git-send-email-linux@roeck-us.net>
References: <1362080229-27334-1-git-send-email-linux@roeck-us.net>
Message-ID: <CACRpkdbir4Ogwp8zcWP9wrAutbepJnNkT3Jfpubf2T0481rRTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 8:37 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> ab8500-sysctrl.c fails to build if POWER_SUPPLY is not configured.
>
> drivers/built-in.o: In function `ab8500_power_off':
> drivers/mfd/ab8500-sysctrl.c:37: undefined reference to `power_supply_get_by_name'
> drivers/mfd/ab8500-sysctrl.c:53: undefined reference to `power_supply_get_by_name'
>
> Select POWER_SUPPLY in Kconfig if AB8500_CORE is configured to fix the problem.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

It appears an identical patch was already submitted in feb 19:
https://patchwork.kernel.org/patch/2163301/

Yours,
Linus Walleij
