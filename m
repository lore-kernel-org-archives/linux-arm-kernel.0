From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Aug 2014 14:19:21 -0700
Subject: [PATCH] clocksource: arch_timer: Fix code to use physical timers
 when requested
In-Reply-To: <1409173419-13076-1-git-send-email-sonnyrao@chromium.org>
References: <1409173419-13076-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <CAOesGMjK65Rc-K0fyFUUJLw6huLT82E-nqJwZO4PqhgopF96Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 2:03 PM, Sonny Rao <sonnyrao@chromium.org> wrote:
> This is a bug fix for using physical arch timers when
> the arch_timer_use_virtual boolean is false.  It restores the
> arch_counter_get_cntpct() function after removal in
>
> 0d651e4e "clocksource: arch_timer: use virtual counters"
>
> and completes the implementation of memory mapped access for physical
> timers, so if a system is trying to use physical timers, it will
> function properly.
>
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>

Acked-by: Olof Johansson <olof@lixom.net>

This should have a:

Fixes: 0d651e4e65e9 ("clocksource: arch_timer: use virtual counters")

tag too, and possibly cc stable?


-Olof
