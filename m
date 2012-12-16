From: olof@lixom.net (Olof Johansson)
Date: Sat, 15 Dec 2012 22:25:02 -0800
Subject: [PATCH] ARM: ux500: fix missing include
In-Reply-To: <1355498788-8702-1-git-send-email-linus.walleij@stericsson.com>
References: <1355498788-8702-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20121216062502.GC15467@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 04:26:28PM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Commit db298da2c31e1dcf7c9b7c9cef6217ad3449ebb7
> "ARM: nomadik: move platform_data definition"
> moved the Ux500-specific musb header from <mach/usb.h>
> to <linux/platform_data/usb-musb-ux500.h>
> 
> However that makes some board code fail to compile
> now:
> 
> CC      arch/arm/mach-ux500/board-mop500.o
> linux/arch/arm/mach-ux500/cpu-db8500.c: In function 'u8500_init_devices':
> linux/arch/arm/mach-ux500/cpu-db8500.c:226:2: error: implicit declaration of function 'ux500_add_usb' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[3]: *** [arch/arm/mach-ux500/cpu-db8500.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [arch/arm/mach-ux500] Error 2
> make[2]: *** Waiting for unfinished jobs....
> 
> So fix this up by adding the proper include file that
> appears to have been brought in implicitly one or another
> way in the past.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC guys,
> here is another patch I'd like to be applied right off on
> the ARM SoC tree as a fixup for problems emerging during
> the merge window.

Applied, thanks.


-Olof
