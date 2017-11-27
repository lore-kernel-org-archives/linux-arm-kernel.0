From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon, 27 Nov 2017 11:44:39 +0100
Subject: [PATCH v8 0/6] stm32 clocksource driver rework
In-Reply-To: <1510649563-22975-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1510649563-22975-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <CA+M3ks5BsC5_2OJ8g0rjd0vQnZ+pYbDhWc807F0J2EejdN6bKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-11-14 9:52 GMT+01:00 Benjamin Gaignard <benjamin.gaignard@linaro.org>:
> version 8:
>  - rebased on timers/core
>  - change timer_of_exit() name to timer_of_cleanup()
>  - update stm32 clocksource driver to use this function
>

Gentle ping to get this v8 reviewed, the first patch has already been merged
int v4.15-rc1

Thanks,
Benjamin

> version 7:
>  - reword "clocksource: stm32: only use 32 bits timers" commit message
>    to give more details about why 16 bits are problematics.
>
> version 6:
>  - add dedicated patch min delta change
>  - rework commit messages, I hope it will be better now
>  - change new function name from timer_of_deinit to timer_of_exit
>  - make stm32_clock_event_set_next_event() safer like done in other
>    drivers
>
> version 6:
> - add timer_of_deinit function in core
> - rework failure cases in probe function
>
> version 5:
> - rebase on top of timer/core branch
> - rework commit message of the first patch
>
> version 4:
> - split patch in 3 parts
>   - convert code to timer_of
>   - only use 32 bits timers
>   - add clocksource support
>
> version 3:
> - fix comments done by Daniel
> - use timer_of helper functions
>
> version 2:
> - fix uninitialized variable
>
> Benjamin Gaignard (6):
>   clocksource: timer_of: rename timer_of_exit to timer_of_cleanup
>   clocksource: stm32: convert driver to timer_of
>   clocksource: stm32: increase min delta value
>   clocksource: stm32: only use 32 bits timers
>   clocksource: stm32: add clocksource support
>   arm: dts: stm32: remove useless clocksource nodes
>
>  arch/arm/boot/dts/stm32f429.dtsi  |  32 -----
>  arch/arm/boot/dts/stm32f746.dtsi  |  32 -----
>  drivers/clocksource/Kconfig       |   1 +
>  drivers/clocksource/timer-of.c    |   9 +-
>  drivers/clocksource/timer-of.h    |   2 +-
>  drivers/clocksource/timer-stm32.c | 242 ++++++++++++++++++++------------------
>  6 files changed, 138 insertions(+), 180 deletions(-)
>
> --
> 2.7.4
>
