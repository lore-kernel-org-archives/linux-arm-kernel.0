From: csd@broadcom.com (Christian Daudt)
Date: Tue, 11 Dec 2012 09:39:02 -0800
Subject: [PATCH V2] ARM: bcm281xx: Add timer driver
In-Reply-To: <50C63285.1030605@us.ibm.com>
References: <1354954544-21429-1-git-send-email-csd@broadcom.com>
 <CAOesGMg3-=ywfgp365_zumsBWBKC+ASxwYpobbkV4_x37P0NoQ@mail.gmail.com>
 <50C63285.1030605@us.ibm.com>
Message-ID: <50C76FB6.5040306@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-12-10 11:05 AM, John Stultz wrote:
>
> But since you pulled me in here, I've got a bike-shedding nit below 
> (Sorry!).
>
>>> diff --git a/drivers/clocksource/bcm_kona_timer.c 
>>> b/drivers/clocksource/bcm_kona_timer.c
>>> new file mode 100644
>>> index 0000000..dbc54c2
>>> --- /dev/null
>>> +++ b/drivers/clocksource/bcm_kona_timer.c
>>>
>>> +static void __init timers_init(void)
>>> +static int timer_set_next_event(unsigned long clc,
>>> +                                 struct clock_event_device *unused)
>>> +static void timer_set_mode(enum clock_event_mode mode,
>>> +                            struct clock_event_device *unused)
>>> +static void __init timer_clockevents_init(void)
>>>
>>> +static irqreturn_t timer_interrupt(int irq, void *dev_id)
>>>
>
> These are all terribly generic function names. I know they're static 
> (and plenty of other driver do the same thing), but it makes grepping 
> for similar code a pain and can cause confusing backtraces.   Maybe 
> consider using the kona_timer_... prefix?
>
Fair enough. I've slapped kona_ in front of all the funcs+vars that 
previously did not have it. V3 coming out soon.

  Thanks,
    csd

> Other then that, for what its worth,
> Acked-by: John Stultz <johnstul@us.ibm.com>
>
> thanks
> -john
>
>
