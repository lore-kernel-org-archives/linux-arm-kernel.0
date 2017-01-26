From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Jan 2017 16:54:06 +0100
Subject: [PATCH v3 01/13] soc: samsung: pmu: Provide global function to
 get PMU regmap
In-Reply-To: <3ba1504d-5874-b09b-1ad8-6cda4851f113@samsung.com>
References: <CGME20170119134904eucas1p153a1d5b2ff9826c88293b6a8fe5140bc@eucas1p1.samsung.com>
 <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <1484833733-16082-2-git-send-email-m.szyprowski@samsung.com>
 <CACRpkdYyOgpAhAY=7QrXiEB2oDgs0azt_Tb80iO4vjzk1obemQ@mail.gmail.com>
 <3ba1504d-5874-b09b-1ad8-6cda4851f113@samsung.com>
Message-ID: <CACRpkdY597rtiW9hk66njtcQRB=YSHThcbuhM0PkQ_yU=a6kXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 11:22 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> syscon_regmap_lookup_by_compatible() requires to have a compatible string
> hardcoded in the client driver. This might be used, but will require to have
> (and maintain) a duplicated list of PMU compatibles in pin control driver.
> There is a little problem with exynos4212 and exynos4412, which have same
> pinctrl compatible (samsung,exynos4x12-pinctrl), but separate PMU
> compatibles

I actually used this approach with the ARM reference designs:
drivers/mtd/maps/physmap_of_versatile.c
drivers/video/fbdev/amba-clcd-versatile.c

It made sense to me, because for each compatible I anyways
needed the .data field to distinguish between the different
system controllers, because they are of course all slightly
idiomatic.

I guess in your case you can distinguish how to use the syscon
by the pinctrl compatible instead.

Oh well.

I guess I'm OK with this then. I'll try to pull it in and see what
happens.

Yours,
Linus Walleij
