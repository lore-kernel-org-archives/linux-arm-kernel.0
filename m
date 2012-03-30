From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 Mar 2012 15:24:34 -0700
Subject: [PATCH 1/2] ARM: fix builds due to missing <asm/system_misc.h>
 includes
In-Reply-To: <1333118281-25295-1-git-send-email-olof@lixom.net>
References: <1333118281-25295-1-git-send-email-olof@lixom.net>
Message-ID: <4F7632A2.7030302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> This does a sweeping change fixing up all the missing system_misc.h and
> system_info.h includes from the system.h split-up change. These were the
> ones I came across when building all defconfigs in arch/arm/configs, there
> might be more but they lack adequate build coverage to be easily caught.
>
> I'm expecting to get a lot of these piecemeal by each maintainer, so we
> might just as well do one sweeping change to get them all at once.
>
>
> Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
> Cc: Russell King<linux@arm.linux.org.uk>
> Cc: Sascha Hauer<kernel@pengutronix.de>
> Cc: Imre Kaloz<kaloz@openwrt.org>
> Cc: Krzysztof Halasa<khc@pm.waw.pl>
> Cc: Eric Miao<eric.y.miao@gmail.com>
> Cc: Haojian Zhuang<haojian.zhuang@gmail.com>
> Cc: Wan ZongShun<mcuos.com@gmail.com>
> Cc: Kukjin Kim<kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thansk, this fixes following:

arch/arm/plat-s3c24xx/cpu.c: In function 's3c24xx_init_io':
arch/arm/plat-s3c24xx/cpu.c:221: error: 'arm_pm_idle' undeclared (first 
use in this function)
arch/arm/plat-s3c24xx/cpu.c:221: error: (Each undeclared identifier is 
reported only once
arch/arm/plat-s3c24xx/cpu.c:221: error: for each function it appears in.)
make[2]: *** [arch/arm/plat-s3c24xx/cpu.o] Error 1
make[2]: *** Waiting for unfinished jobs....

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Signed-off-by: Olof Johansson<olof@lixom.net>
> ---
>   arch/arm/mach-at91/at91x40.c  |    1 +
>   arch/arm/mach-at91/setup.c    |    1 +
>   arch/arm/mach-h720x/common.c  |    1 +
>   arch/arm/mach-imx/mm-imx3.c   |    1 +
>   arch/arm/mach-imx/mm-imx5.c   |    1 +
>   arch/arm/mach-ixp23xx/core.c  |    1 +
>   arch/arm/mach-ixp4xx/common.c |    1 +
>   arch/arm/mach-pxa/raumfeld.c  |    2 ++
>   arch/arm/mach-shark/core.c    |    1 +
>   arch/arm/mach-w90x900/dev.c   |    1 +
>   arch/arm/plat-s3c24xx/cpu.c   |    1 +
>   11 files changed, 12 insertions(+)

[...]
