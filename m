From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 20 Sep 2011 12:43:50 -0500
Subject: [PATCH v2] mach-ep93xx: break out GPIO driver specifics
In-Reply-To: <1316508132-20020-1-git-send-email-linus.walleij@stericsson.com>
References: <1316508132-20020-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F39DAED82F@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 20, 2011 1:42 AM, Linus Walleij wrote:
>
> From: Linus Walleij <linus.walleij@linaro.org>
>
> The <mach/gpio.h> file is included from upper directories
> and deal with generic GPIO and gpiolib stuff. Break out the
> platform and driver specific defines and functions into its own
> header file.
>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Move the irq_to_gpio() into the driver since it was the only
>   thing actually using it, as a result the ep93xx gpio.h
>   is trivial and becomes empty.
> - Putting this into the patch tracker as 7042/2 soon-ish.
> ---
>  arch/arm/mach-ep93xx/core.c                     |    1 +
>  arch/arm/mach-ep93xx/edb93xx.c                  |    1 +
>  arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h |  100 +++++++++++++++++++++
>  arch/arm/mach-ep93xx/include/mach/gpio.h        |  105 -----------------------
>  arch/arm/mach-ep93xx/simone.c                   |    2 +-
>  arch/arm/mach-ep93xx/snappercl15.c              |    2 +-
>  drivers/gpio/gpio-ep93xx.c                      |    3 +
>  7 files changed, 107 insertions(+), 107 deletions(-)
>  create mode 100644 arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks!
