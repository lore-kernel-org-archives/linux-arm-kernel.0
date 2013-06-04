From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 08:34:44 +0200
Subject: [PATCH 01/10] clocksource: dw_apb_timer_of: use the clocksource
 as sched clock if necessary
In-Reply-To: <201306030056.03522.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
 <201306030056.03522.heiko@sntech.de>
Message-ID: <CACRpkdYAvUQ+aymJm1Fw1bE1aGdO7RUqLR9byvoT7ECTk4tkpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 3, 2013 at 12:56 AM, Heiko St?bner <heiko@sntech.de> wrote:

> Currently the dw_apb_timer always expects a separate special timer to be
> availbable for the sched_clock. Some devices using dw_apb_timers do not
> have the sptimer but can use the clocksource as sched_clock.
> Therefore this patch adds using the clocksource timer as
> a fallback if no usable sched timer is found.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Is this really what the patch does? I mean "ass the clocksourse as
fallback", it seems more like that is controlled from the device tree,
this looks more like some more careful handling of the device tree
input making the sched_timer optional, it doesn't really "add"
anything, does it?

Yours,
Linus Walleij
