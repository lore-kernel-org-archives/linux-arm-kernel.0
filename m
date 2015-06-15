From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Mon, 15 Jun 2015 17:25:26 +0000
Subject: [PATCH 0/5] EP93xx GENERIC_CLOCKEVENTS
In-Reply-To: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
References: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D883D49CA16@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 15, 2015 6:50 AM, Linus Walleij wrote:
> This converts the EP93xx to GENERIC_CLOCKEVENTS.
>
> After this only the RISC PC and EBSA110 uses GETTIMEOFFSET.
>
> Linus Walleij (5):
>   ARM: ep93xx: move timer to its own file
>   ARM: ep93xx: switch to GENERIC_CLOCKEVENTS
>   ARM: ep93xx: use non-raw accessors for timer
>   ARM: ep93xx: switch clockevent to timer 3
>   ARM: ep93xx: activate NO_HZ and high-res timers
>
>  arch/arm/Kconfig                    |   3 +-
>  arch/arm/configs/ep93xx_defconfig   |   2 +
>  arch/arm/mach-ep93xx/Makefile       |   2 +-
>  arch/arm/mach-ep93xx/core.c         | 109 ----------------------------
>  arch/arm/mach-ep93xx/timer-ep93xx.c | 141 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 146 insertions(+), 111 deletions(-)
>  create mode 100644 arch/arm/mach-ep93xx/timer-ep93xx.c

Hi Linus,

Tested on Vision Engraving Systems EP9307 (vision_ep9307.c).

You can use whatever tag is appropriate:

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>


One nit...

Is the "Timer handling for EP93xx" comment still correct?

It still mentions a 16-bit timer (timer 1) used for the timer interrupt and gettimeoffset()
being used with timer 4.

Regards,
Hartley
