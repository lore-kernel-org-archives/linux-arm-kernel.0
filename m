From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Feb 2016 14:18:44 +0100
Subject: [PATCH] ARM: sa1100: make sa1100_register_uart_fns a function
In-Reply-To: <1456238094-778916-1-git-send-email-arnd@arndb.de>
References: <1456238094-778916-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdbJpYD2Ke-f2QP+-fy_LcxhiV99OEH_D=CMtSvedEveVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 3:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Calling sa1100_register_uart_fns() leaves the port structure
> unused when CONFIG_SERIAL_SA1100 is disabled, and we get a
> compiler warning about that:
>
> arch/arm/mach-sa1100/badge4.c:317:31: warning: 'badge4_port_fns' defined but not used [-Wunused-variable]
>  static struct sa1100_port_fns badge4_port_fns __initdata = {
>
> This turns the two empty macros into empty inline functions,
> which has the same effect, but lets the compiler know that the
> variables are intentionally unused.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

>  include/linux/platform_data/sa11x0-serial.h | 8 ++++++--

It looks like you should send this to Greg?

Yours,
Linus Walleij
