From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 20:07:56 +0200
Subject: [PATCHv4 4/4] clocksource: dw_apb_timer_of: Fix read_sched_clock
In-Reply-To: <1377189026-16656-4-git-send-email-dinguyen@altera.com>
References: <1377189026-16656-1-git-send-email-dinguyen@altera.com>
 <1377189026-16656-4-git-send-email-dinguyen@altera.com>
Message-ID: <CACRpkdY1=xi3OL0UEQ=ToH=xvU1iySzhzOxdwPdULham3GgxjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 6:30 PM,  <dinguyen@altera.com> wrote:

> From: Dinh Nguyen <dinguyen@altera.com>
>
> The read_sched_clock should return the ~value because the clock is a
> countdown implementation. read_sched_clock() should be the same as
> __apbt_read_clocksource().
>
> If a separate timer for the sched_clock exist, then read_sched_clock()
> will return an incorrect value. The (sched_io_base + 0x4) needs to be in
> the function for both cases.
>
> Maintain backwards compatibility for "dw-apb-timer-sp" and
> "dw-apb-timer-osc".
>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Jamie Iles <jamie@jamieiles.com>
> CC: Rob Herring <rob.herring@calxeda.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> CC: Jamie Iles <jamie@jamieiles.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-arm-kernel at lists.infradead.org
>
> v3:
> - Use APBTMR_N_CURRENT_VALUE define in read_sched_clock()

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
