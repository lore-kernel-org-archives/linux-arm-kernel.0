From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Jun 2012 19:28:45 +0200
Subject: [PATCH 1/1] ARM: ux500: Fix build errors/warnings when
 MACH_UX500_DT is not set
In-Reply-To: <1339749776-9468-1-git-send-email-lee.jones@linaro.org>
References: <1339749776-9468-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaLNOFdQZ3i0+7gSCKBreHsxaO93X9HwTbLBz7L=gLFcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2012 at 10:42 AM, Lee Jones <lee.jones@linaro.org> wrote:

> When MACH_UX500_DT and all related Device Tree configurations are forced
> off the warning and error below prevent the kernel from compiling. This
> simple patch fixes both issues and allows for full build and boot of
> ST-Ericsson's low-cost development board, Snowball.
>
> Warnings fixed:
> ?arch/arm/mach-ux500/board-mop500.c:680:32: warning: ?snowball_of_platform_devs? defined but not used
>
> Errors fixed:
> ?arch/arm/mach-ux500/timer.c: In function ?ux500_timer_init?:
> ?arch/arm/mach-ux500/timer.c:66:3: error: implicit declaration of function ?of_find_matching_node?
> ?arch/arm/mach-ux500/timer.c:66:6: warning: assignment makes pointer from integer without a cast
>
> Cc: stable at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing, will you send this upstream to the ARM SoC tree please?
(I've screwed up too many DT patches trying to funnel them, probably becayse I
don't yet use DT myself.)

Linus Walleij
