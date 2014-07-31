From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Thu, 31 Jul 2014 06:46:45 +0200
Subject: [RFC 0/5] ARM: EXYNOS: ODROID-XU DT and LEDs
In-Reply-To: <1406549892-5558-1-git-send-email-afaerber@suse.de>
References: <1406549892-5558-1-git-send-email-afaerber@suse.de>
Message-ID: <53D9CA35.1030800@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

Am 28.07.2014 14:18, schrieb Andreas F?rber:
> Hello,
> 
> This series adds a dedicated ODROID-XU device tree and enhances it with 
> LED configuration, to match the downstream 3.14 based behavior.
> 
> It had turned out less trivial than I initially thought as the whole 
> pinctrl stuff is still missing. I thus cherry-pick two downstream commits.
> 
> Hakjoo, can you please reply with a Signed-off-by to your patches
> so that we can get them into upstream? Thanks in advance!

FTR, Hakjoo Kim did reply with signed off patches (thanks again!) and
updated their branch accordingly:

https://github.com/hardkernel/linux/commits/odroid-3.14.y-linaro
https://github.com/hardkernel/linux/commit/53edc3da0d1da287517681b47daf36679637b6ba
https://github.com/hardkernel/linux/commit/afdc310e47e4d1799719566bfb5a47c55141a7cb

> Andreas F?rber (3):
>   ARM: dts: exynos5410: Clean up SMDK5410 indentation
>   ARM: dts: exynos5410: Prepare ODROID-XU device tree

The functional changes below haven't been reviewed yet, but could you
consider applying trivial patches 1-2?

Regards,
Andreas

>   ARM: dts: exynos5410: Add ODROID-XU LEDs
> 
> Hakjoo Kim (2):
>   pinctrl: exynos: add exynos5410 SoC specific data
>   ARM: dts: add pinctrl support to Exynos5410
> 
>  .../bindings/pinctrl/samsung-pinctrl.txt           |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/exynos5410-odroidxu.dts          | 111 ++++++
>  arch/arm/boot/dts/exynos5410-pinctrl.dtsi          | 408 +++++++++++++++++++++
>  arch/arm/boot/dts/exynos5410-smdk5410.dts          |   6 +-
>  arch/arm/boot/dts/exynos5410.dtsi                  |  32 ++
>  drivers/pinctrl/pinctrl-exynos.c                   | 126 +++++++
>  drivers/pinctrl/pinctrl-samsung.c                  |   2 +
>  drivers/pinctrl/pinctrl-samsung.h                  |   1 +
>  9 files changed, 685 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts
>  create mode 100644 arch/arm/boot/dts/exynos5410-pinctrl.dtsi
> 


-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
