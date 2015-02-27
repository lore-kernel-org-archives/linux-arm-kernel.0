From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Feb 2015 13:22:26 +0100
Subject: [PATCH 03/10] clk/realview: stop using machine headers
In-Reply-To: <1424967051-261375-1-git-send-email-arnd@arndb.de>
References: <1424967051-261375-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdb1VvkfkGf-9pJZPtR6bACuALRzFG4BaU86qxzRjT29pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 5:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> In order to move realview into multiplatform, we have to prevent device
> drivers from accessing the machine header files.
>
> In case of the clk driver, this is very simple, we just copy the
> small set of register definitions into the driver that needs them.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sweet. We should move this to using syscon to access the registers
I guess but in the meantime this is still nice modularization.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
