From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Feb 2016 15:23:27 +0100
Subject: [PATCH 3/4] ARM: realview: imply Device Tree config
In-Reply-To: <1456406111-18579-4-git-send-email-linus.walleij@linaro.org>
References: <1456406111-18579-1-git-send-email-linus.walleij@linaro.org>
 <1456406111-18579-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <2805017.I27kg8jfk6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 February 2016 14:15:10 Linus Walleij wrote:
> @@ -32,8 +24,9 @@ config REALVIEW_DT
>         select USE_OF
>         select ZONE_DMA

The 'select USE_OF' can now be dropped, I guess this was left over
from the multiplatform patches, but also fits in here.

>         help
> -         Include support for booting the ARM(R) RealView(R) evaluation
> -         boards using a device tree machine description.
> +         This enables support for ARM Ltd RealView boards.
> +
> +if ARCH_REALVIEW
>  
>  config REALVIEW_HIGH_PHYS_OFFSET
>         bool "High physical base address for the RealView platform"
> 

REALVIEW_HIGH_PHYS_OFFSET can go away as well, as it is only used
in 'realview_fixup', which in turn is called by the removed board
files.

	Arnd
