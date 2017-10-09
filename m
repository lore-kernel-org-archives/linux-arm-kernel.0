From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon, 9 Oct 2017 11:23:01 +0200
Subject: [PATCH v4 0/4] stm32 clocksource driver rework
In-Reply-To: <1506959513-16851-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1506959513-16851-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <CA+M3ks551+w1wtg9O_bYRiTjx00M8qOBsB92og2-EL0Wnrf2rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-02 17:51 GMT+02:00 Benjamin Gaignard <benjamin.gaignard@linaro.org>:
> version 4:
> - split patch in 3 parts
>   - convert code to timer_of
>   - only use 32 bits timers
>   - add clocksource support

Hello Daniel,

Does the patches split sound good for you ?

Regards,
Benjamin

>
> version 3:
> - fix comments done by Daniel
> - use timer_of helper functions
>
> version 2:
> - fix uninitialized variable
>
> These patches implements clocksource and clockevent by using only one hardware block.
> Getting both clock source and events on the same hardware lead to change quite
> a lot driver code.
> It also limits usage of clocksource to 32 bits timers because 16 bits ones
> aren't enough accurate.
> Thanks to timer_fo helpers this series includes minor clean up in structures,
> function prototypes and driver name.
>
> Since 16 bits timers become useless it also removes them from stm32f4 and
> stm32f7 devicetree.
>
> Benjamin Gaignard (4):
>   clocksource: stm32: convert driver to timer_of
>   clocksource: stm32: only use 32 bits timers
>   clocksource: stm32: add clocksource support
>   arm: dts: stm32: remove useless clocksource nodes
>
>  arch/arm/boot/dts/stm32f429.dtsi  |  32 ------
>  arch/arm/boot/dts/stm32f746.dtsi  |  32 ------
>  drivers/clocksource/Kconfig       |   1 +
>  drivers/clocksource/timer-stm32.c | 229 ++++++++++++++++++--------------------
>  4 files changed, 112 insertions(+), 182 deletions(-)
>
> --
> 2.7.4
>



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
