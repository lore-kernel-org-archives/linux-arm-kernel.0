From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Feb 2013 10:13:50 +0100
Subject: [PATCH 07/11] ARM: integrator: fix build with INTEGRATOR_AP off
In-Reply-To: <1360849767-1463135-8-git-send-email-arnd@arndb.de>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
 <1360849767-1463135-8-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkda2A6upoT30vFfZM+a4dO=7tStVhHj_JoT-Oe16Pvuy=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 2:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The conditional declaration of ap_uart_data is broken
> and causes this build error:
>
> In file included from arch/arm/mach-integrator/core.c:35:0:
> arch/arm/mach-integrator/common.h:6:37: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
>
> Turning the check into an constant-expression if(IS_ENABLED()) statement
> creates more readable code and solves this problem as well.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>

Brilliant Arnd, thanks for fixing this!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
