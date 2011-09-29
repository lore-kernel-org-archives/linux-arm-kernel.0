From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 29 Sep 2011 23:26:21 +0800
Subject: [PATCH 2/2 v2] plat-pxa: break out GPIO driver specifics
In-Reply-To: <1317121014-4749-1-git-send-email-linus.walleij@stericsson.com>
References: <1317121014-4749-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAN1soZyCLc-vA5heAWGKkajUx58a2BuiJskB6FApzGb+y0ZO0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 6:56 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> The <mach/gpio.h> file is included from upper directories
> and deal with generic GPIO and gpiolib stuff. Break out the
> platform and driver specific defines and functions into its own
> header file.
>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ?arch/arm/mach-mmp/aspenite.c ? ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-mmp/brownstone.c ? ? ? ? ? ? | ? ?1 -
> ?arch/arm/mach-mmp/gplugd.c ? ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-mmp/include/mach/gpio-pxa.h ?| ? 30 ++++++
> ?arch/arm/mach-mmp/include/mach/gpio.h ? ? ?| ? 23 -----
> ?arch/arm/mach-mmp/jasper.c ? ? ? ? ? ? ? ? | ? ?1 -
> ?arch/arm/mach-mmp/mmp2.c ? ? ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-mmp/pxa168.c ? ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-mmp/pxa910.c ? ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-mmp/tavorevb.c ? ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-pxa/cm-x255.c ? ? ? ? ? ? ? ?| ? ?1 -
> ?arch/arm/mach-pxa/include/mach/gpio-pxa.h ?| ?133 ++++++++++++++++++++++++++++
> ?arch/arm/mach-pxa/include/mach/gpio.h ? ? ?| ?110 +----------------------
> ?arch/arm/mach-pxa/include/mach/littleton.h | ? ?2 +-
> ?arch/arm/mach-pxa/irq.c ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/mfp-pxa2xx.c ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-pxa/pxa25x.c ? ? ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-pxa/pxa27x.c ? ? ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-pxa/pxa3xx.c ? ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/pxa95x.c ? ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/saarb.c ? ? ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/plat-pxa/include/plat/gpio-pxa.h ?| ? 44 +++++++++
> ?arch/arm/plat-pxa/include/plat/gpio.h ? ? ?| ? 40 +--------
> ?drivers/gpio/gpio-pxa.c ? ? ? ? ? ? ? ? ? ?| ? ?2 +
> ?24 files changed, 227 insertions(+), 180 deletions(-)
> ?create mode 100644 arch/arm/mach-mmp/include/mach/gpio-pxa.h
> ?create mode 100644 arch/arm/mach-pxa/include/mach/gpio-pxa.h
> ?create mode 100644 arch/arm/plat-pxa/include/plat/gpio-pxa.h
>
I think that we can move gpio out of plat-pxa directory. And gpio
driver needs to be simplified by supporting both pxa and mmp.

I sent a new patch series for review.

Thanks
Haojian
