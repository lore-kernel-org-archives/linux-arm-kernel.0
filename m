From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 23:04:29 +0100
Subject: [PATCH] ARM/ARM64: defconfig: drop GPIO_SYSFS on multiplatforms
In-Reply-To: <1479999472-2664-1-git-send-email-linus.walleij@linaro.org>
References: <1479999472-2664-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <5151997.6RlLpvHqsO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 24, 2016 3:57:52 PM CET Linus Walleij wrote:
> The sysfs ABI to GPIO is marked obsolete and should not be
> encouraged. Users should be encouraged to switch to using the
> character device.
> 
> Let's begin by removing it from the multi defconfigs. Then
> as time goes by I can aggressively remove it from other
> defconfigs.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this for whatever branch holds
> defconfig changes.
> ---
>  arch/arm/configs/multi_v5_defconfig | 1 -
>  arch/arm/configs/multi_v7_defconfig | 1 -
>  arch/arm64/configs/defconfig        | 1 -
>  3 files changed, 3 deletions(-)
> 

Hmm, while this is a trivial change, we normally put the defconfig
changes for arm and arm64 into two separate next/* branches.

I've split the patch up accordingly and slightly modified the
changelog text to match.

	Arnd
