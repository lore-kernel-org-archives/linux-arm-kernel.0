From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 11:04:31 +0100
Subject: [PATCH 06/10] ARM: realview: enable multiplatform
In-Reply-To: <1448469143-447355-7-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
 <1448469143-447355-7-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdZwD7=h7oXdWZ6a6j5sXRcY0pKc2xuY6QsVfyNzpaWBMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 5:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> All obstacles are out of the way by now, so we can finally move realview
> to multiplatform.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
(...)

> -obj-y                                  := core.o
>  obj-$(CONFIG_REALVIEW_DT)              += realview-dt.o
> +ifdef $(CONFIG_ATAGS)
> +obj-y                                  := core.o
>  obj-$(CONFIG_MACH_REALVIEW_EB)         += realview_eb.o
>  obj-$(CONFIG_MACH_REALVIEW_PB11MP)     += realview_pb11mp.o
>  obj-$(CONFIG_MACH_REALVIEW_PB1176)     += realview_pb1176.o
>  obj-$(CONFIG_MACH_REALVIEW_PBA8)       += realview_pba8.o
>  obj-$(CONFIG_MACH_REALVIEW_PBX)                += realview_pbx.o
> +endif

This isn't working. Even if CONFIG_ATAGS is set, none of the files
inside this ifdef $(CONFIG_ATAGS) are compiled. Does Kconfig
only support if and not ifdef?

I just removed it to get things to compile. (But sadly it doesn't
boot...)

Yours,
Linus Walleij
