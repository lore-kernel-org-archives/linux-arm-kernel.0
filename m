From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 15 Jan 2015 10:41:46 -0800
Subject: [PATCH 0/2] clockevents: introduce ->set_dev_mode() and convert a
 few drivers
In-Reply-To: <1418162614-19182-1-git-send-email-khilman@kernel.org>
References: <1418162614-19182-1-git-send-email-khilman@kernel.org>
Message-ID: <CAMAWPa8WFgQw4ydGiNXCV1N60tNLL0odg5GrVVd0WahTvUCsgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

Gentle reminder ping...

On Tue, Dec 9, 2014 at 2:03 PM, Kevin Hilman <khilman@kernel.org> wrote:
> From: Kevin Hilman <khilman@linaro.org>
>
> Currently, the ->set_mode() method of a clockevent device is not
> allowed to fail, so it has no return value.  In order to add new
> clockevent modes, and allow the setting of those modes to fail, we
> need the clockevent core to be able to detect when setting a mode
> fails.
>
> Rather than changing the current ->set_mode() and requiring all
> clockevent devices to change immedately, introduce a new mode setting
> method ->set_dev_mode() which returns 'int'.
>
> In addition, migrate a few drivers over to the new method to
> demonstrate how the new method is to be used, and how to convert.
>
> Proposal for new method originally suggested by Thomas Gleixner[1].
>
> [1] https://lkml.org/lkml/2014/5/10/86
>
> Viresh Kumar (2):
>   clockevents: introduce ->set_dev_mode() which can return error
>   clockevents: migrate some drivers to new ->set_dev_mode()
>
>  drivers/clocksource/arm_arch_timer.c     | 46 +++++++++++++++++---------------
>  drivers/clocksource/bcm2835_timer.c      | 10 +++----
>  drivers/clocksource/bcm_kona_timer.c     | 15 ++++++++---
>  drivers/clocksource/i8253.c              | 11 +++++---
>  drivers/clocksource/time-armada-370-xp.c | 21 +++++++++++----
>  include/linux/clockchips.h               |  5 +++-
>  kernel/time/clockevents.c                | 21 ++++++++++++---
>  kernel/time/timer_list.c                 |  5 +++-
>  8 files changed, 91 insertions(+), 43 deletions(-)
>
> --
> 2.1.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
