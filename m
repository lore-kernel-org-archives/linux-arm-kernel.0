From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 19 May 2015 10:59:11 +0200
Subject: [PATCH] ARM: stm32: fix decompressor build
In-Reply-To: <3033772.rbvAY6l8ZR@wuerfel>
References: <3033772.rbvAY6l8ZR@wuerfel>
Message-ID: <CALszF6CQJeGyn8usDzcNSbO+qzBk_+emDPq1Vsde5VwsxZiHhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2015-05-18 17:15 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> The stm32 defconfig uses XIP_KERNEL, but if this is turned off
> by a user, we get this error when building the zImage decompressor:
>
> arch/arm/boot/compressed/misc.c:28:35: fatal error: mach/uncompress.h: No such file or directory
>
> To avoid the error, this adds stm32 to the list of platforms using
> the default DEBUG_LL based decompressor output.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'd like to apply this directly to next/soc
>

Indeed, I tested only with XIP_KERNEL..

The patch looks good to me:
Acked-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Thanks,
Maxime
