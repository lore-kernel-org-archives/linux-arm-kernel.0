From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 4 Jul 2012 22:36:54 +0800
Subject: [GIT PULL] prima2 GPIO support in pinmux
In-Reply-To: <201207041429.47124.arnd@arndb.de>
References: <CAGsJ_4xrk0w5aQy+ZSYZwQ3pW5My7dcHnDX57+985VTbdHXCzg@mail.gmail.com>
 <201207041429.47124.arnd@arndb.de>
Message-ID: <CAGsJ_4zjKprZn+gDASsKg9pspntagNMOvuQSj1VdK_YgzXn6hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/7/4 Arnd Bergmann <arnd@arndb.de>:
> On Monday 02 July 2012, Barry Song wrote:
>> Hi Olof, Arnd,
>>
>> Please pull the following GPIO support in pinmux for 3.6.
>
> I noticed that the driver now requires gpiolib, so we need one
> of these two patches. I think the first one is safer, but the
> second one allows you to build without GPIOLIB if you want to
> disable PINCTRL_SIRF.

yes. missed this. thanks!
i would have 1 because basically we will always have PINCTRL_SIRF.

>
>         Arnd
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 8bcda59..adef0da 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -389,7 +389,7 @@ config ARCH_PRIMA2
>         bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
>         select CPU_V7
>         select NO_IOPORT
> -       select ARCH_WANT_OPTIONAL_GPIOLIB
> +       select ARCH_REQUIRE_GPIOLIB
>         select GENERIC_CLOCKEVENTS
>         select CLKDEV_LOOKUP
>         select GENERIC_IRQ_CHIP
>
>
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 4c05fe8..5b51199 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -104,7 +104,7 @@ config PINCTRL_PXA910
>
>  config PINCTRL_SIRF
>         bool "CSR SiRFprimaII pin controller driver"
> -       depends on ARCH_PRIMA2
> +       depends on ARCH_PRIMA2 && GPIOLIB
>         select PINMUX
>
>  config PINCTRL_TEGRA

-barry
