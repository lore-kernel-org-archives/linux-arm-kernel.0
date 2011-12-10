From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 10 Dec 2011 01:04:59 +0100
Subject: [PATCH] [RFC] pinctrl: add a driver for Energy Micro's efm32 SoCs
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1750B77BD8@HQMAIL01.nvidia.com>
References: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF1750B77BD8@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdbOo6MhQhWJmT4Q49BjsAU94obKdvvsSQ=KreiL1y_owg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/12/9 Stephen Warren <swarren@nvidia.com>:

> Uwe Kleine-K?nig wrote at Thursday, December 08, 2011 3:41 PM:
>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
>
>> +config PINMUX_EFM32
>> + ? ? bool "EFM32 pinmux driver"
>> + ? ? depends on ARCH_EFM32
>> + ? ? default y
>> + ? ? select PINMUX
>
> LinusW,
>
> Since this is the pinctrl not pinmux subsystem now, does it make sense
> to name the driver Kconfig options PINCTRL_FOO and the files pinctrl-
> foo.c? I see that the coh901 driver already does that, and I followed
> that convention in my Tegra pinctrl patches.

Hm, the U300 pinmux is named pinmux-u300.c because it can only do
pinmux. It cannot do anything else. But if it's confusing we can surely
name everything pinctrl-*.

Yours,
Linus Walleij
